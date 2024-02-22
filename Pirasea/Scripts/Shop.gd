extends CanvasLayer

var player_in_area = false
var cards_selected = []
var unlockable = ["ThreeMusketeers", "TrainedCrew", "ExperincedCrew", "EliteCrew"]

#player opening/closing the shop
func _unhandled_key_input(event):
		if Input.is_action_pressed("shop") and self.visible == false and player_in_area == true: 
			_pause()
			_open_shop()
		elif Input.is_action_pressed("shop") and self.visible == true: 
			_unpause()
			_close_shop()

#functions
func _pause():
	get_tree().paused = true
	show()

func _unpause():
	hide()
	get_tree().paused = false
	
func _reset_shop():
	var unlocked_left = []
	for cd in get_node("/root/Main/Shop/Cards").get_children():
		if str(cd).split(":")[0] in str(unlockable): pass
		else: unlocked_left.append(cd)
	if len(unlocked_left) <= 3:
		for i in unlocked_left:
			i.visible = true
	else:
		for i in range(0, 3):
			var card_selected = randi_range(0, len(get_node("/root/Main/Shop/Cards").get_children())-1)
			while card_selected in cards_selected or str(_unlocked_card(card_selected)) == "Reset":
				card_selected = randi_range(0, len(get_node("/root/Main/Shop/Cards").get_children())-1)
			get_node("/root/Main/Shop/Cards").get_child(card_selected).visible = true
			cards_selected.append(card_selected)
			
func _unlocked_card(selected_card):
	var card = get_node("/root/Main/Shop/Cards").get_child(selected_card)
	card = str(card).split(":")[0]
	if str(card) in str(unlockable):
		print("Reset")
		return "Reset"
	else:
		return "Good"
	
func _open_shop():
	print(cards_selected)
	if cards_selected == []:
		_reset_shop()
	else:
		for i in cards_selected:
			get_node("/root/Main/Shop/Cards").get_child(i).visible = true
	
func _close_shop():
	get_node("/root/Main/Shop").visible = false
	for i in get_node("/root/Main/Shop/Cards").get_children():
		i.visible = false
	_unpause()

#player entering the shop area
func _on_shop_area_body_entered(body):
	if "player" in str(body).to_lower():
		player_in_area = true

func _on_shop_area_body_exited(body):
	if "player" in str(body).to_lower():
		player_in_area = false

#upgrades and perks
func _on_more_place_powder_button_pressed():
	if AutoloadScript.player_money >= int($Cards/MoreBlackPowder/Price/Cost.text):
		AutoloadScript.cannon_ball_speed += 100
		AutoloadScript.player_money -= int($Cards/MoreBlackPowder/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		if AutoloadScript.cannon_ball_speed >= 600:
			$Cards/MoreBlackPowder.queue_free()
		cards_selected = []
		_close_shop()

func _on_more_crew_button_pressed():
	if AutoloadScript.player_money >= int($Cards/MoreCrew/Price/Cost.text):
		get_node("/root/Main/Cannonball").wait_time = .85
		AutoloadScript.player_money -= int($Cards/MoreCrew/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/MoreCrew.queue_free()
		unlockable.pop_at(unlockable.find("TrainedCrew"))
		cards_selected = []
		_close_shop()

func _on_bigger_sails_button_pressed():
	if AutoloadScript.player_money >= int($Cards/BiggerSails/Price/Cost.text):
		AutoloadScript.player_speed += 20
		AutoloadScript.player_money -= int($Cards/BiggerSails/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/BiggerSails.queue_free()
		cards_selected = []
		_close_shop()

func _on_bigger_rudder_button_pressed():
	if AutoloadScript.player_money >= int($Cards/BiggerRudder/Price/Cost.text):
		AutoloadScript.player_turn_speed += 10
		AutoloadScript.player_money -= int($Cards/BiggerRudder/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/BiggerRudder.queue_free()
		cards_selected = []
		_close_shop()

func _on_stronger_wood_button_pressed():
	if AutoloadScript.player_money >= int($Cards/StrongerWood/Price/Cost.text):
		AutoloadScript.player_health += 1
		AutoloadScript.player_max_health += 1
		get_node("/root/Main/Player/Camera2D/UI/HealthBar").value = float(AutoloadScript.player_health) / AutoloadScript.player_max_health*100
		AutoloadScript.player_money -= int($Cards/StrongerWood/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/StrongerWood.queue_free()
		cards_selected = []
		_close_shop()

func _on_double_trouble_button_pressed():
	if AutoloadScript.player_money >= int($Cards/DoubleTrouble/Price/Cost.text):
		AutoloadScript.cannon_ball_amount = 2
		AutoloadScript.player_money -= int($Cards/DoubleTrouble/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/DoubleTrouble.queue_free()
		cards_selected = []
		unlockable.pop_at(unlockable.find("ThreeMusketeers"))
		_close_shop()

func _on_three_musketeers_button_pressed():
	if AutoloadScript.player_money >= int($Cards/ThreeMusketeers/Price/Cost.text):
		AutoloadScript.cannon_ball_amount = 3
		AutoloadScript.player_money -= int($Cards/ThreeMusketeers/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/ThreeMusketeers.queue_free()
		cards_selected = []
		_close_shop()

func _on_trained_crew_button_pressed():
	if AutoloadScript.player_money >= int($Cards/TrainedCrew/Price/Cost.text):
		get_node("/root/Main/Cannonball").wait_time = .60
		AutoloadScript.player_money -= int($Cards/TrainedCrew/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/TrainedCrew.queue_free()
		unlockable.pop_at(unlockable.find("ExperincedCrew"))
		cards_selected = []
		_close_shop()

func _on_wealthier_enemies_button_pressed():
	if AutoloadScript.player_money >= int($Cards/WealthierEnemies/Price/Cost.text):
		AutoloadScript.double_drop_chance += 1
		AutoloadScript.player_money -= int($Cards/WealthierEnemies/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		if AutoloadScript.double_drop_chance == 4:
			$Cards/WealthierEnemies.queue_free()
		cards_selected = []
		_close_shop()

func _on_experinced_crew_button_pressed():
	if AutoloadScript.player_money >= int($Cards/ExperincedCrew/Price/Cost.text):
		get_node("/root/Main/Cannonball").wait_time = .45
		AutoloadScript.player_money -= int($Cards/ExperincedCrew/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/ExperincedCrew.queue_free()
		unlockable.pop_at(unlockable.find("EliteCrew"))		
		cards_selected = []
		_close_shop()

func _on_elite_crew_button_pressed():
	if AutoloadScript.player_money >= int($Cards/EliteCrew/Price/Cost.text):
		get_node("/root/Main/Cannonball").wait_time = .30
		AutoloadScript.player_money -= int($Cards/EliteCrew/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		$Cards/EliteCrew.queue_free()
		cards_selected = []
		_close_shop()
