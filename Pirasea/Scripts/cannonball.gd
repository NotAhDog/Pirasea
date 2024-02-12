extends RigidBody2D




func _on_disappear_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if "island" in str(body).to_lower() or "enemy" in str(body).to_lower():
		queue_free()
