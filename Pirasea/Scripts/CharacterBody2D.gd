extends CharacterBody2D

var wheel_base = 34
var steering_angle = 25
var engine_power = 50
var friction = -10
var drag = -0.01
var braking = -100
var max_speed_reverse = 15
var slip_speed = 100
var traction_fast = 1
var traction_slow = 10
var acceleration = Vector2.ZERO
var steer_direction
var health = 3


func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction(delta)
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()
	AutoloadScript.player_position = position

func apply_friction(delta):
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction * delta
	var drag_force = velocity * velocity.length() * drag * delta
	acceleration += drag_force + friction_force

func get_input():

	var turn = Input.get_axis("left", "right")
	steer_direction = turn * deg_to_rad(steering_angle)
	if Input.is_action_pressed("foward"):
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("backwards"):
		acceleration = transform.x * braking


func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading = rear_wheel.direction_to(front_wheel)
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = lerp(velocity, new_heading * velocity.length(), traction * delta)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
# velocity = new_heading * velocity.length()
	rotation = new_heading.angle()

func _on_area_2d_body_entered(body):
	AutoloadScript.damaged()
