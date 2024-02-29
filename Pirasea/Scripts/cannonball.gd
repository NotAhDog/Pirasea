extends RigidBody2D




func _on_disappear_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if "static" in str(body).to_lower() or "character" in str(body).to_lower():
		queue_free()
