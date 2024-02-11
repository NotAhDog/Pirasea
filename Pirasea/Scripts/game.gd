extends Node


var cannonball = preload("res://Scenes/cannonball.tscn")
var cannonballxv = 0
var cannonballyv = 0

func _on_cannonball_timeout():
	_spawn_cannon_ball($Player/SpawnHandler/Spawn1.global_position, "left")
	print($Player/SpawnHandler/Spawn1.position)
	_spawn_cannon_ball($Player/SpawnHandler/Spawn2.global_position, "left")
	_spawn_cannon_ball($Player/SpawnHandler/Spawn3.global_position, "right")
	_spawn_cannon_ball($Player/SpawnHandler/Spawn4.global_position, "right")


func _spawn_cannon_ball(spawn_location, side):
	var cannonballinstance = cannonball.instantiate()
	add_child(cannonballinstance)
	cannonballinstance.position = spawn_location
	if side == "left":
		cannonballxv = cos($Player.rotation + 4.712385)*200
		cannonballyv = sin($Player.rotation + 4.712385)*200
	if side == "right":
		cannonballxv = cos($Player.rotation + 1.570795)*200
		cannonballyv = sin($Player.rotation + 1.570795)*200
	cannonballinstance.linear_velocity = Vector2(cannonballxv,cannonballyv)

#instead of using left and right, read the y value, if y is negative, do left spawning.
