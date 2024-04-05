extends Node

var cannonball = preload("res://Scenes/cannonball.tscn")
var enemygalleon = preload("res://Scenes/enemygalleon.tscn")
var enemyrammer = preload("res://Scenes/rammer.tscn")
var enemybomber = preload("res://Scenes/bomber.tscn")
var pirategalleon = preload("res://Scenes/pirate_galleon.tscn")
var piraterammer = preload("res://Scenes/pirate_rammer.tscn")
var piratebomber = preload("res://Scenes/pirate_boomer.tscn")
var navywarship = preload("res://Scenes/navywarship.tscn")
var ghostship = preload("res://Scenes/ghostship.tscn")
var cannonballxv = 0
var cannonballyv = 0
var island0 = preload("res://Scenes/water.tscn")
var island1 = preload("res://Scenes/island_1.tscn")
var island2 = preload("res://Scenes/island_2.tscn")
var island3 = preload("res://Scenes/island_3.tscn")
var island4 = preload("res://Scenes/island_4.tscn")
var island5 = preload("res://Scenes/island_5.tscn")
var island6 = preload("res://Scenes/island_6.tscn")
var island7 = preload("res://Scenes/island_7.tscn")
var island0amount = 0
var island1amount = 0
var island2amount = 0
var island3amount = 0
var island4amount = 0
var island5amount = 0
var island6amount = 0
var island7amount = 0
var progressionLevel = 0

func _ready():
	AutoloadScript.player_health += 1
	for i in range(6):
		var yposis = 1000 + (i * 2000)
		for x in range(6):
			var xposis = 1000 + (x * 2000)
			_spawn_island(randi_range(1,9), xposis, yposis)
	print("Water: " + str(island0amount))
	print("Island 1: " + str(island1amount))
	print("Island 2: " + str(island2amount))
	print("Shops: " + str(island3amount))

func _spawn_island(island, x, y):
	var islandinstance = island0.instantiate() 
	var randdirection = [0.0, 90.0, 180.0, 270.0]
	if island == 1: 
		islandinstance = island1.instantiate() 
		island1amount += 1
	elif island == 2: 
		islandinstance = island2.instantiate() 
		island2amount += 1
	elif island == 3: 
		islandinstance = island3.instantiate() 
		island3amount += 1
	elif island == 4: 
		islandinstance = island4.instantiate() 
		island4amount += 1
	elif island == 5: 
		islandinstance = island5.instantiate() 
		island5amount += 1
	elif island == 6: 
		islandinstance = island6.instantiate() 
		island6amount += 1
	elif island == 7: 
		islandinstance = island7.instantiate() 
		island7amount += 1
	else:
		island0amount += 1
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
	if progressionLevel > 2 and progressionLevel <= 10:
		$Galleon.wait_time -= 0.25
	if progressionLevel > 4 and progressionLevel <= 13:
		$Rammer.wait_time -= 1/3
	if progressionLevel == 4:
		$Rammer.start(0)
	if progressionLevel == 8:
		$Bomber.start(0)
	if progressionLevel > 8 and progressionLevel <= 14:
		$Rammer.wait_time -= 1/3
	#At the 5 minute mark, Rammers spawn every 8 seconds and Galleons 2 seconds
	#At the 7 minutes mark, rammers are spawning ever 6 2/3 seconds and Bombers every 6 seconds
	if progressionLevel == 20:
		$PirateRammer.start(0)
		$Rammer.paused = true
	elif progressionLevel == 22:
		$PirateGalleon.start(0)
		$Galleon.paused = true
	elif progressionLevel == 24:
		$PirateBomber.start(0)
		$Bomber.paused = true
	#BOSS FIGHTS
	if progressionLevel == 10:
		for x in range(4):
			var fleet = pirategalleon.instantiate()
			self.add_child(fleet)
			fleet.position = AutoloadScript._choose_random_spawn()
		for x in range(4):
			var fleet = piraterammer.instantiate()
			self.add_child(fleet)
			fleet.position = AutoloadScript._choose_random_spawn()
		for x in range(4):
			var fleet = piratebomber.instantiate()
			self.add_child(fleet)
			fleet.position = AutoloadScript._choose_random_spawn()
	elif progressionLevel == 20:
		var warship = navywarship.instantiate()
		self.add_child(warship)
		warship.position = AutoloadScript._choose_random_spawn()
	elif progressionLevel == 30:
		var ghostship = ghostship.instantiate()
		self.add_child(ghostship)
		ghostship.position = AutoloadScript._choose_random_spawn()
	#DEBUG
	print("Progression Level: " + str(progressionLevel))
	print("Galleon " + str($Galleon.wait_time))
	print("Rammer " + str($Rammer.wait_time))
	print("Bomber " + str($Bomber.wait_time))
	print("Pirate Galleon " + str($PirateGalleon.wait_time))
	print("Pirate Rammer " + str($PirateRammer.wait_time))
	print("Pirate Bomber " + str($PirateBomber.wait_time))

func _on_pirate_bomber_timeout():
	var ship = piratebomber.instantiate()
	add_child(ship)
	ship.position = AutoloadScript._choose_random_spawn()

func _on_pirate_galleon_timeout():
	var ship = pirategalleon.instantiate()
	add_child(ship)
	ship.position = AutoloadScript._choose_random_spawn()

func _on_pirate_rammer_timeout():
	var ship = piraterammer.instantiate()
	add_child(ship)
	ship.position = AutoloadScript._choose_random_spawn()

func _on_bomber_timeout():
	var ship = enemybomber.instantiate()
	add_child(ship)
	ship.position = AutoloadScript._choose_random_spawn()
