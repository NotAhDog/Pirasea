extends Node


var cannonball = preload("res://Scenes/cannonball.tscn")

func _on_cannonball_timeout():
	var cannonballinstance = cannonball.instantiate()
	add_child(cannonballinstance)
	print("TIME")
