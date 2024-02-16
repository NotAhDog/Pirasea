extends CanvasLayer

var player_in_area = false
var cards_selected = []

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
	
func _open_shop():
	for i in range(0, 3):
		var card_selected = randi_range(0, len(get_node("/root/Main/Shop/Cards").get_children())-1)
		while card_selected in cards_selected:
			card_selected = randi_range(0, len(get_node("/root/Main/Shop/Cards").get_children())-1)
		get_node("/root/Main/Shop/Cards").get_child(card_selected).visible = true
		cards_selected.append(card_selected)
	cards_selected = []
	
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
		_close_shop()

func _on_more_crew_button_pressed():
	if AutoloadScript.player_money >= int($Cards/MoreCrew/Price/Cost.text):
		get_node("/root/Main/Cannonball").wait_time = .75
		AutoloadScript.player_money -= int($Cards/MoreCrew/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		_close_shop()

func _on_bigger_sails_button_pressed():
	if AutoloadScript.player_money >= int($Cards/BiggerSails/Price/Cost.text):
		AutoloadScript.player_speed += 20
		AutoloadScript.player_money -= int($Cards/BiggerSails/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		_close_shop()

func _on_bigger_rudder_button_pressed():
	if AutoloadScript.player_money >= int($Cards/BiggerRudder/Price/Cost.text):
		AutoloadScript.player_turn_speed += 10
		AutoloadScript.player_money -= int($Cards/BiggerRudder/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		_close_shop()

func _on_stronger_wood_button_pressed():
	if AutoloadScript.player_money >= int($Cards/StrongerWood/Price/Cost.text):
		AutoloadScript.player_health += 1
		AutoloadScript.player_max_health += 1
		get_node("/root/Main/Player/Camera2D/UI/HealthBar").value = float(AutoloadScript.player_health) / AutoloadScript.player_max_health*100
		AutoloadScript.player_money -= int($Cards/StrongerWood/Price/Cost.text)
		get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		_close_shop()
