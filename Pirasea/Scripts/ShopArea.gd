extends Area2D

var player_in_area = true
var timeout = false

#player opening/closing the shop
func _input(event): #The shop opens and closes multiple times when e is pressed once
	if timeout == false and event.is_echo() == false:
		print(event)
		if Input.is_action_just_pressed("shop"):
			timeout = true
			if get_node("/root/Main/Shop").visible == true: 
				_close_shop()
			elif player_in_area == true: 
				_open_shop()
			await get_tree().create_timer(1).timeout
			timeout = false

#functions
func _pause():
	print("pause")
	get_node("/root/Main/Shop").show()

func _unpause():
	print("unpause")
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
	_pause()
	if AutoloadScript.cards_selected == []:
		_reset_shop()
	else:
		for i in AutoloadScript.cards_selected:
			get_node("/root/Main/Shop/Cards").get_child(i).visible = true
	
func _close_shop():
	get_node("/root/Main/Shop").hide()
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
