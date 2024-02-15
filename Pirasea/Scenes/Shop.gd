extends CanvasLayer

var player_in_area = false

func _unhandled_key_input(event):
	if Input.is_action_pressed("shop") and self.visible == false and player_in_area == true:
		get_tree().paused = true
		show()
	elif Input.is_action_pressed("shop") and self.visible == true:
		hide()
		get_tree().paused = false

func _on_shop_area_body_entered(body):
	if "player" in str(body).to_lower():
		player_in_area = true


func _on_shop_area_body_exited(body):
	if "player" in str(body).to_lower():
		player_in_area = false
