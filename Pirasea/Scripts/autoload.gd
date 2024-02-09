extends Node

var player_position
var player_health = 3


func damaged():
	player_health -= 1
	if player_health <= 0:
		print("player dead") #respawn
