extends Area2D


func _on_body_entered(body):
	if "player" in str(body).to_lower():
		AutoloadScript.player_money += 1
		get_node("../Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		queue_free()
