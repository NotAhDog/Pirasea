extends CanvasLayer

func _on_visibility_changed():
	get_tree().paused = true

func _on_resume_button_pressed():
	hide()
	get_tree().paused = false
