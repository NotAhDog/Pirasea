extends Area2D


func _on_body_entered(body):
	if "player" in str(body).to_lower():
		AutoloadScript.player_money += 1
		get_node("../Player/Camera2D/UI/Money").text = "Money: " + str(AutoloadScript.player_money)
		AutoloadScript.total_collected_money += 1
		get_node("../Player/Camera2D/UI/CollectedMoney").text = "Total Collected Money: " + str(AutoloadScript.player_money)
		queue_free()
