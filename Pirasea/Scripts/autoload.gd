extends Node

var player_position
var player_max_health = 3
var player_health = 3
var player_money = 0
var total_collected_money = 0
var player_speed = 50
var player_turn_speed = 25
var cannon_ball_speed = 300
var cannon_ball_amount = 1
var double_drop_chance = 0
var knockback = false
var iframes = false
var unlockable = ["ThreeMusketeers", "TrainedCrew", "ExperincedCrew", "EliteCrew"]
var cards_selected = []
# WHEN CHANGING VARIABLES, CHANGE IN DAMAGE FUNCTION AS WELL

func damaged(body):
	if iframes == false:
		if "boom" in str(body).to_lower() or "body" in str(body).to_lower():
			print("Hit by: " + str(body) + ", at: " + str(Time.get_ticks_msec()))
			player_health -= 1
			iframes = true
			get_node("/root/Main/Player/Camera2D/UI/HealthBar").value = float(player_health) / player_max_health*100
			if player_health <= 0:
				get_tree().reload_current_scene()
				player_max_health = 3
				player_health = 3
				player_money = 0
				total_collected_money = 0
				player_speed = 50
				player_turn_speed = 25
				cannon_ball_speed = 300
				cannon_ball_amount = 1
				double_drop_chance = 0
				knockback = false
				iframes = false
				unlockable = ["ThreeMusketeers", "TrainedCrew", "ExperincedCrew", "EliteCrew"]
				cards_selected = []
			elif "Player" not in str(body):
				knockback = true
				await get_tree().create_timer(2).timeout
				knockback = false
			await get_tree().create_timer(1).timeout
			iframes = false

func _choose_random_spawn():
	var screen_side_spawn = randi_range(1,4)
	var enemyspawn = get_node("/root/Main/Player").global_position
	if screen_side_spawn == 1:
		enemyspawn.y += 2000
		enemyspawn.x += randi_range(-2000,2000)
	if screen_side_spawn == 2:
		enemyspawn.x += 2000
		enemyspawn.y += randi_range(-2000,2000)
	if screen_side_spawn == 3:
		enemyspawn.y += -2000
		enemyspawn.x += randi_range(-2000,2000)
	if screen_side_spawn == 4:
		enemyspawn.x += -2000
		enemyspawn.y += randi_range(-2000,2000)
	return enemyspawn

func _full_screen(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
