extends Area2D


var player_in_area = false


#player opening/closing the shop
func _unhandled_key_input(event):
		if Input.is_action_pressed("shop") and get_node("/root/Main/Shop").visible == false and player_in_area == true: 
			_pause()
			_open_shop()
		elif Input.is_action_pressed("shop") and get_node("/root/Main/Shop").visible == true: 
			_unpause()
			_close_shop()

#functions
func _pause():
	print("Paused")
	get_node("/root/Main/Shop").show()

func _unpause():
	print("Unpaused")
	get_node("/root/Main/Shop").hide()
	

func _reset_shop():
	var unlocked_left = []
	for cd in get_node("/root/Main/Shop/Cards").get_children():
		if str(cd).split(":")[0] in str(AutoloadScript.unlockable): pass
		else: unlocked_left.append(cd)
	if len(unlocked_left) <= 3:
		for i in unlocked_left:
			i.visible = true
	else:
		for i in range(0, 3):
			var card_selected = randi_range(0, len(get_node("/root/Main/Shop/Cards").get_children())-1)
			while card_selected in AutoloadScript.cards_selected or str(_unlocked_card(card_selected)) == "Reset":
				card_selected = randi_range(0, len(get_node("/root/Main/Shop/Cards").get_children())-1)
			get_node("/root/Main/Shop/Cards").get_child(card_selected).visible = true
			AutoloadScript.cards_selected.append(card_selected)
			
func _unlocked_card(selected_card):
	var card = get_node("/root/Main/Shop/Cards").get_child(selected_card)
	card = str(card).split(":")[0]
	if str(card) in str(AutoloadScript.unlockable):
		print("Reset" + card)
		return "Reset"
	else:
		return "Good"
	
func _open_shop():
	print(AutoloadScript.cards_selected)
	if AutoloadScript.cards_selected == []:
		_reset_shop()
	else:
		for i in AutoloadScript.cards_selected:
			get_node("/root/Main/Shop/Cards").get_child(i).visible = true
	
func _close_shop():
	get_node("/root/Main/Shop").visible = false
	for i in get_node("/root/Main/Shop/Cards").get_children():
		i.visible = false
	_unpause()

func _on_body_entered(body):
	print(body)
	if "player" in str(body).to_lower():
		player_in_area = true

func _on_body_exited(body):
	if "player" in str(body).to_lower():
		player_in_area = false
