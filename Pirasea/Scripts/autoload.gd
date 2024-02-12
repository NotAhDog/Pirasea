extends Node

var player_position
var player_health = 4
var player_money = 0


func damaged():
	player_health -= 1
	if player_health <= 0:
		get_tree().reload_current_scene()
		player_health = 4
