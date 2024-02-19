extends CharacterBody2D

var speed = 50
var coin = preload("res://Scenes/coin.tscn")

func _process(delta):
	velocity = position.direction_to(AutoloadScript.player_position) * speed
	move_and_slide()
	if velocity[0] > 0: rotation = atan(velocity[1]/velocity[0])
	else: rotation = atan(velocity[1]/velocity[0]) + 3.14159

func _on_area_2d_area_entered(area):
	print(area)
	if "cannonball" in str(area).to_lower():
		var chance = randi_range(1, 4)
		if chance <= AutoloadScript.double_drop_chance:
			for i in range(1,2):
				var coininstance = coin.instantiate()
				get_node("..").add_child(coininstance)
				coininstance.global_position = self.global_position
				self.queue_free()
		else:
			var coininstance = coin.instantiate()
			get_node("..").add_child(coininstance)
			coininstance.global_position = self.global_position
			self.queue_free()

func _on_area_2d_body_entered(body):
	if $Timer.wait_time > 0 and "island" in str(body).to_lower():
		self.position = AutoloadScript._choose_random_spawn()
		$Timer.wait_time = 0.1

func _on_timer_timeout():
	show()
