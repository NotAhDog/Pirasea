extends Node


var cannonball = preload("res://Scenes/cannonball.tscn")
var cannonballxv = 0
var cannonballyv = 0

func _on_cannonball_timeout():
	for i in get_node("Player/SpawnHandler").get_children():
		_spawn_cannon_ball(i.global_position, i.position)

func _spawn_cannon_ball(spawn_location, side):
	var cannonballinstance = cannonball.instantiate()
	add_child(cannonballinstance)
	cannonballinstance.position = spawn_location
	if side[1] < 0:
		cannonballxv = cos($Player.rotation + 4.712385)*300
		cannonballyv = sin($Player.rotation + 4.712385)*300
	if side[1] > 0:
		cannonballxv = cos($Player.rotation + 1.570795)*300
		cannonballyv = sin($Player.rotation + 1.570795)*300
	cannonballinstance.linear_velocity = Vector2(cannonballxv,cannonballyv)
