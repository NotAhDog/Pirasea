extends Node


var cannonball = preload("res://Scenes/cannonball.tscn")
var enemygalleon = preload("res://Scenes/enemygalleon.tscn")
var enemyrammer = preload("res://Scenes/rammer.tscn")
var cannonballxv = 0
var cannonballyv = 0

func _ready():
	AutoloadScript.player_health += 1

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
