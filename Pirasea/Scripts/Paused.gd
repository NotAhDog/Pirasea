extends CanvasLayer

func _unhandled_key_input(event):
	if Input.is_action_pressed("pause") and self.visible == false:
		get_tree().paused = true
		get_node("/root/Main/Shop").visible = false
		show()
	elif Input.is_action_pressed("pause") and self.visible == true:
		hide()
		get_tree().paused = false

