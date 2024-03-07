extends CanvasLayer

func _unhandled_key_input(event):
	if Input.is_action_pressed("pause") and self.visible == false:
		get_tree().paused = true
		get_node("/root/Main/Shop").visible = false
		show()
	elif Input.is_action_pressed("pause") and self.visible == true:
		hide()
		get_tree().paused = false

func _on_resume_pressed():
	hide()
	get_tree().paused = false

func _on_settings_pressed():
	hide()
	get_node("/root/Main/PopUpSettings").visible = true
	
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
