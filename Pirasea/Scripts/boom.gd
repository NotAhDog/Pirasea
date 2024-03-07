extends Area2D

func _process(delta):
	self.scale += Vector2(0.25, 0.25)

func _on_delete_timeout():
	self.queue_free()
