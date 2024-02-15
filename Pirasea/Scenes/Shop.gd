extends CanvasLayer

var player_in_area = false

#player opening/closing the shop
func _unhandled_key_input(event):
		if Input.is_action_pressed("shop") and self.visible == false and player_in_area == true: 
			_pause()
			_open_shop()
		elif Input.is_action_pressed("shop") and self.visible == true: _unpause()

#functions
func _pause():
	get_tree().paused = true
	show()

func _unpause():
	hide()
	get_tree().paused = false
	
func _open_shop():
	pass
	
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
	AutoloadScript.cannon_ball_speed += 100
	AutoloadScript.player_money -= int($Cards/MoreBlackPowder/Price/Cost.text)
	get_node("/root/Main/Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
	_close_shop()
