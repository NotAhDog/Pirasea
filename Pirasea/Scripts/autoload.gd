extends Node

var player_position
var player_health = 4000000000000
var player_money = 0


func damaged():
	player_health -= 1
	if player_health <= 0:
		get_tree().reload_current_scene()
		player_health = 4

func _choose_random_spawn():
	var screen_side_spawn = randi_range(1,4)
	var enemyspawn = get_node("/root/Main/Player").global_position
	if screen_side_spawn == 1:
		enemyspawn.y += 512
		enemyspawn.x += randi_range(-768,768)
	if screen_side_spawn == 2:
		enemyspawn.x += 768
		enemyspawn.y += randi_range(-512,512)
	if screen_side_spawn == 3:
		enemyspawn.y += -512
		enemyspawn.x += randi_range(-768,768)
	if screen_side_spawn == 4:
		enemyspawn.x += -768
		enemyspawn.y += randi_range(-512,512)
	return enemyspawn
