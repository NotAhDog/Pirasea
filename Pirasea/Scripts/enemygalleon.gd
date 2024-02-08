extends CharacterBody2D

var speed = 50

func _process(delta):
	velocity = position.direction_to(AutoloadScript.player_position) * speed
	move_and_slide()
	if velocity[0] > 0: rotation = atan(velocity[1]/velocity[0])
	else: rotation = atan(velocity[1]/velocity[0]) + 3.14159

