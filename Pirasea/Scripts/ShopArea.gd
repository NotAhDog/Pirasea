extends Area2D

var player_in_area = null
var timeout = false
var open = false

#player opening/closing the shop
func _unhandled_key_input(event): #The shop opens and closes multiple times when e is pressed once
	if event.pressed == true:
		if Input.is_action_pressed("shop") and player_in_area == self:
			if open == false: 
				_open_shop()
				open = true
			else:
				_close_shop()
				open = false

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
		player_in_area = self
		print(self, player_in_area)

func _on_body_exited(body):
	if "player" in str(body).to_lower():
		player_in_area = null
