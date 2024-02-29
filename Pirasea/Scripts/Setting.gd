extends Control



func _on_check_button_toggled(toggled_on):
	AutoloadScript._full_screen(toggled_on)


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
