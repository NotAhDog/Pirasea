extends Node


var cannonball = preload("res://Scenes/cannonball.tscn")

func _on_cannonball_timeout():
	$CannonballHandler.add_child(cannonball)
	print("TIME")
