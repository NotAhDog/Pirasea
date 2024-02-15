extends Area2D


func _on_body_entered(body):
	if "player" in str(body).to_lower():
		AutoloadScript.player_money += 1
		
		queue_free()
