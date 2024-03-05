extends Area2D

var player_in_area = true
var timeout = false

#player opening/closing the shop
func _unhandled_key_input(event): #The shop opens and closes multiple times when e is pressed once
	if event.is_action_pressed("shop"):
		if timeout == false and event.is_echo() == false:
			timeout = true
			print(event)
			print(str(Time.get_ticks_msec()))
			if get_node("/root/Main/Shop").visible == true: 
				_close_shop()
				print("DAMNIT")
			elif player_in_area == true: 
				_open_shop()
				print("DAMNIT")
			await get_tree().create_timer(.25).timeout
			timeout = false

#functions
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
	get_node("/root/Main/Shop").show()
	if AutoloadScript.cards_selected == []:
		_reset_shop()
	else:
		for i in AutoloadScript.cards_selected:
			get_node("/root/Main/Shop/Cards").get_child(i).visible = true
	
func _close_shop():
	get_node("/root/Main/Shop").hide()
	for i in get_node("/root/Main/Shop/Cards").get_children():
		i.visible = false

func _on_body_entered(body):
	if "player" in str(body).to_lower():
		player_in_area = true

func _on_body_exited(body):
	if "player" in str(body).to_lower():
		player_in_area = false
