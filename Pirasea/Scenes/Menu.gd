extends Control

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Setting.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
