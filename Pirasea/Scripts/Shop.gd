extends CanvasLayer

var player_in_area = false

func _close_shop():
	get_node("/root/Main/Shop").visible = false
	for i in get_node("/root/Main/Shop/Cards").get_children():
		i.visible = false
	hide()
	get_tree().paused = false

#upgrades and perks
func _on_more_place_powder_button_pressed():
	if AutoloadScript.player_money >= int($Cards/MoreBlackPowder/Price/Cost.text):
		AutoloadScript.cannon_ball_speed += 100
		AutoloadScript.player_money -= int($Cards/MoreBlackPowder/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		if AutoloadScript.cannon_ball_speed >= 600:
			$Cards/MoreBlackPowder.queue_free()
		AutoloadScript.cards_selected = []
		_close_shop()

func _on_more_crew_button_pressed():
	if AutoloadScript.player_money >= int($Cards/MoreCrew/Price/Cost.text):
		get_node("/root/Main/Cannonball").wait_time = .85
		AutoloadScript.player_money -= int($Cards/MoreCrew/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/MoreCrew.queue_free()
		AutoloadScript.unlockable.pop_at(AutoloadScript.unlockable.find("TrainedCrew"))
		AutoloadScript.cards_selected = []
		_close_shop()

func _on_bigger_sails_button_pressed():
	if AutoloadScript.player_money >= int($Cards/BiggerSails/Price/Cost.text):
		AutoloadScript.player_speed += 20
		AutoloadScript.player_money -= int($Cards/BiggerSails/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/BiggerSails.queue_free()
		AutoloadScript.cards_selected = []
		_close_shop()

func _on_bigger_rudder_button_pressed():
	if AutoloadScript.player_money >= int($Cards/BiggerRudder/Price/Cost.text):
		AutoloadScript.player_turn_speed += 10
		AutoloadScript.player_money -= int($Cards/BiggerRudder/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/BiggerRudder.queue_free()
		AutoloadScript.cards_selected = []
		_close_shop()

func _on_stronger_wood_button_pressed():
	if AutoloadScript.player_money >= int($Cards/StrongerWood/Price/Cost.text):
		AutoloadScript.player_health += 1
		AutoloadScript.player_max_health += 1
		get_node("/root/Main/Player/Camera2D/UI/HealthBar").value = float(AutoloadScript.player_health) / AutoloadScript.player_max_health*100
		AutoloadScript.player_money -= int($Cards/StrongerWood/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/StrongerWood.queue_free()
		AutoloadScript.cards_selected = []
		_close_shop()

func _on_double_trouble_button_pressed():
	if AutoloadScript.player_money >= int($Cards/DoubleTrouble/Price/Cost.text):
		AutoloadScript.cannon_ball_amount = 2
		AutoloadScript.player_money -= int($Cards/DoubleTrouble/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/DoubleTrouble.queue_free()
		AutoloadScript.cards_selected = []
		AutoloadScript.unlockable.pop_at(AutoloadScript.unlockable.find("ThreeMusketeers"))
		_close_shop()

func _on_three_musketeers_button_pressed():
	if AutoloadScript.player_money >= int($Cards/ThreeMusketeers/Price/Cost.text):
		AutoloadScript.cannon_ball_amount = 3
		AutoloadScript.player_money -= int($Cards/ThreeMusketeers/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/ThreeMusketeers.queue_free()
		AutoloadScript.cards_selected = []
		_close_shop()

func _on_trained_crew_button_pressed():
	if AutoloadScript.player_money >= int($Cards/TrainedCrew/Price/Cost.text):
		get_node("/root/Main/Cannonball").wait_time = .60
		AutoloadScript.player_money -= int($Cards/TrainedCrew/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/TrainedCrew.queue_free()
		AutoloadScript.unlockable.pop_at(AutoloadScript.unlockable.find("ExperincedCrew"))
		AutoloadScript.cards_selected = []
		_close_shop()

func _on_wealthier_enemies_button_pressed():
	if AutoloadScript.player_money >= int($Cards/WealthierEnemies/Price/Cost.text):
		AutoloadScript.double_drop_chance += 1
		AutoloadScript.player_money -= int($Cards/WealthierEnemies/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		if AutoloadScript.double_drop_chance == 4:
			$Cards/WealthierEnemies.queue_free()
		AutoloadScript.cards_selected = []
		_close_shop()

func _on_experinced_crew_button_pressed():
	if AutoloadScript.player_money >= int($Cards/ExperincedCrew/Price/Cost.text):
		get_node("/root/Main/Cannonball").wait_time = .45
		AutoloadScript.player_money -= int($Cards/ExperincedCrew/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/ExperincedCrew.queue_free()
		AutoloadScript.unlockable.pop_at(AutoloadScript.unlockable.find("EliteCrew"))		
		AutoloadScript.cards_selected = []
		_close_shop()

func _on_elite_crew_button_pressed():
	if AutoloadScript.player_money >= int($Cards/EliteCrew/Price/Cost.text):
		get_node("/root/Main/Cannonball").wait_time = .30
		AutoloadScript.player_money -= int($Cards/EliteCrew/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/EliteCrew.queue_free()
		AutoloadScript.cards_selected = []
		_close_shop()

func _on_visibility_changed():
	if self.visible == true: get_tree().paused = true
	else: get_tree().paused = false
