extends Node

var cannonball = preload("res://Scenes/cannonball.tscn")
var enemygalleon = preload("res://Scenes/enemygalleon.tscn")
var enemyrammer = preload("res://Scenes/rammer.tscn")
var cannonballxv = 0
var cannonballyv = 0
var island0 = preload("res://Scenes/water.tscn")
var island1 = preload("res://Scenes/island_1.tscn")
var island2 = preload("res://Scenes/island_2.tscn")
var island3 = preload("res://Scenes/island_3.tscn")
var progressionLevel = 0

func _ready():
	AutoloadScript.player_health += 1
	for i in range(6):
		var yposis = 1000 + (i * 2000)
		for x in range(6):
			var xposis = 1000 + (x * 2000)
			_spawn_island(randi_range(0,4), xposis, yposis)
			
func _spawn_island(island, x, y):
	var islandinstance = island0.instantiate() 
	var randdirection = [0.0, 90.0, 180.0, 270.0]
	if island == 1: 
		islandinstance = island1.instantiate() 
	if island == 2: 
		islandinstance = island2.instantiate() 
	if island == 3: 
		islandinstance = island3.instantiate() 
	add_child(islandinstance)
	islandinstance.position.x = x
	islandinstance.position.y = y
	islandinstance.rotation = deg_to_rad(randdirection.pick_random())
		
func _on_cannonball_timeout():
	for i in get_node("Player/SpawnHandler").get_children():
		_spawn_cannon_ball(i.global_position, i.position)

func _spawn_cannon_ball(spawn_location, side):
	if AutoloadScript.cannon_ball_amount == 1:
		var cannonballinstance = cannonball.instantiate()
		add_child(cannonballinstance)
		cannonballinstance.position = spawn_location
		if side[1] < 0:
			cannonballxv = cos($Player.rotation + 4.712385)*AutoloadScript.cannon_ball_speed
			cannonballyv = sin($Player.rotation + 4.712385)*AutoloadScript.cannon_ball_speed
		elif side[1] > 0:
			cannonballxv = cos($Player.rotation + 1.570795)*AutoloadScript.cannon_ball_speed
			cannonballyv = sin($Player.rotation + 1.570795)*AutoloadScript.cannon_ball_speed
		cannonballinstance.linear_velocity = Vector2(cannonballxv,cannonballyv)
	if AutoloadScript.cannon_ball_amount == 2:
		for i in range(2):
			var cannonballinstance = cannonball.instantiate()
			add_child(cannonballinstance)
			cannonballinstance.position = spawn_location
			if side[1] < 0 and i == 0:
				cannonballxv = cos($Player.rotation + 4.450586)*AutoloadScript.cannon_ball_speed
				cannonballyv = sin($Player.rotation + 4.450586)*AutoloadScript.cannon_ball_speed
			elif side[1] > 0 and i == 0:
				cannonballxv = cos($Player.rotation + 1.308996)*AutoloadScript.cannon_ball_speed
				cannonballyv = sin($Player.rotation + 1.308996)*AutoloadScript.cannon_ball_speed
			elif side[1] < 0 and i == 1:
				cannonballxv = cos($Player.rotation + 4.974184)*AutoloadScript.cannon_ball_speed
				cannonballyv = sin($Player.rotation + 4.974184)*AutoloadScript.cannon_ball_speed
			elif side[1] > 0 and i == 1:
				cannonballxv = cos($Player.rotation + 1.832594)*AutoloadScript.cannon_ball_speed
				cannonballyv = sin($Player.rotation + 1.832594)*AutoloadScript.cannon_ball_speed
			cannonballinstance.linear_velocity = Vector2(cannonballxv,cannonballyv)
	if AutoloadScript.cannon_ball_amount == 3:
		for i in range(3):
			var cannonballinstance = cannonball.instantiate()
			add_child(cannonballinstance)
			cannonballinstance.position = spawn_location
			if side[1] < 0 and i == 0:
				cannonballxv = cos($Player.rotation + 4.450586)*AutoloadScript.cannon_ball_speed
				cannonballyv = sin($Player.rotation + 4.450586)*AutoloadScript.cannon_ball_speed
			elif side[1] > 0 and i == 0:
				cannonballxv = cos($Player.rotation + 1.308996)*AutoloadScript.cannon_ball_speed
				cannonballyv = sin($Player.rotation + 1.308996)*AutoloadScript.cannon_ball_speed
			elif side[1] < 0 and i == 1:
				cannonballxv = cos($Player.rotation + 4.974184)*AutoloadScript.cannon_ball_speed
				cannonballyv = sin($Player.rotation + 4.974184)*AutoloadScript.cannon_ball_speed
			elif side[1] > 0 and i == 1:
				cannonballxv = cos($Player.rotation + 1.832594)*AutoloadScript.cannon_ball_speed
				cannonballyv = sin($Player.rotation + 1.832594)*AutoloadScript.cannon_ball_speed
			elif side[1] < 0 and i == 2:
				cannonballxv = cos($Player.rotation + 4.712385)*AutoloadScript.cannon_ball_speed
				cannonballyv = sin($Player.rotation + 4.712385)*AutoloadScript.cannon_ball_speed
			elif side[1] > 0 and i == 2:
				cannonballxv = cos($Player.rotation + 1.570795)*AutoloadScript.cannon_ball_speed
				cannonballyv = sin($Player.rotation + 1.570795)*AutoloadScript.cannon_ball_speed
			cannonballinstance.linear_velocity = Vector2(cannonballxv,cannonballyv)

func _on_enemy_galleon_timeout():
	var enemygalleoninstance = enemygalleon.instantiate()
	add_child(enemygalleoninstance)
	enemygalleoninstance.position = AutoloadScript._choose_random_spawn()
	
func _on_rammer_timeout():
	var enemyrammerinstance = enemyrammer.instantiate()
	add_child(enemyrammerinstance)
	enemyrammerinstance.position = AutoloadScript._choose_random_spawn()

func _on_progression_timeout():
	progressionLevel += 1
	if progressionLevel == 1:
		$Galleon.wait_time = 4
	if progressionLevel >= 2 and progressionLevel <= 5:
		$Galleon.wait_time -= 0.5
		$Rammer.wait_time -= 0.5
	if progressionLevel == 2:
		$Rammer.start
		
