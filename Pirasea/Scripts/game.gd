extends Node


var cannonball = preload("res://Scenes/cannonball.tscn")
var enemygalleon = preload("res://Scenes/enemygalleon.tscn")
var cannonballxv = 0
var cannonballyv = 0

func _ready():
	AutoloadScript.player_health += 1

func _on_cannonball_timeout():
	for i in get_node("Player/SpawnHandler").get_children():
		_spawn_cannon_ball(i.global_position, i.position)

func _spawn_cannon_ball(spawn_location, side):
	var cannonballinstance = cannonball.instantiate()
	add_child(cannonballinstance)
	cannonballinstance.position = spawn_location
	if side[1] < 0:
		cannonballxv = cos($Player.rotation + 4.712385)*AutoloadScript.cannon_ball_speed
		cannonballyv = sin($Player.rotation + 4.712385)*AutoloadScript.cannon_ball_speed
	if side[1] > 0:
		cannonballxv = cos($Player.rotation + 1.570795)*AutoloadScript.cannon_ball_speed
		cannonballyv = sin($Player.rotation + 1.570795)*AutoloadScript.cannon_ball_speed
	cannonballinstance.linear_velocity = Vector2(cannonballxv,cannonballyv)

func _on_enemy_galleon_timeout():
	var enemygalleoninstance = enemygalleon.instantiate()
	add_child(enemygalleoninstance)
	enemygalleoninstance.position = AutoloadScript._choose_random_spawn()
	
