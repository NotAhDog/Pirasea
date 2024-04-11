extends CharacterBody2D

var speed = 100
var coin = preload("res://Scenes/coin.tscn")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
var boom = preload("res://Scenes/boom.tscn")

func _ready():
	_make_path()
	$SpawnTimer.start(0.25)

func _physics_process(delta): 
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	if AutoloadScript.knockback == false: velocity = dir * speed
	if AutoloadScript.knockback == true: velocity = -(dir * speed)*1.5
	move_and_slide()
	if velocity[0] > 0: 
		$Sprite2D.rotation = atan(velocity[1]/velocity[0]) + 1.5708
		$CollisionPolygon2D.rotation = atan(velocity[1]/velocity[0]) 
		$Area2D.rotation = atan(velocity[1]/velocity[0]) 
	else: 
		$Sprite2D.rotation = atan(velocity[1]/velocity[0]) + 3.14159 + 1.5708
		$CollisionPolygon2D.rotation = atan(velocity[1]/velocity[0]) + 3.14159
		$Area2D.rotation = atan(velocity[1]/velocity[0]) + 3.14159
	
func _make_path() -> void:
	nav_agent.target_position = get_node("/root/Main/Player").global_position

func _on_nav_timeout():
	_make_path() 

func _on_area_2d_area_entered(area):
	if "cannonball" in str(area).to_lower() or "boom" in str(area).to_lower():
		var chance = randi_range(1, 4)
		if chance <= AutoloadScript.double_drop_chance:
			for i in range(2):
				var coininstance = coin.instantiate()
				get_node("..").add_child(coininstance)
				coininstance.global_position = self.global_position
		else:
			var coininstance = coin.instantiate()
			get_node("..").add_child(coininstance)
			coininstance.global_position = self.global_position
		AutoloadScript.total_kills += 1
		get_node("../DeadScreen/Stats/StatsLabel/Kills").text = "Total kills(not including bosses):
		" + str(AutoloadScript.total_kills)
		self.queue_free()

func _on_area_2d_body_entered(body):
	if $SpawnTimer.time_left > 0 and "island" in str(body).to_lower():
		self.position = AutoloadScript._choose_random_spawn()
		$SpawnTimer.start(0.25)

func _on_timer_timeout():
	show()
