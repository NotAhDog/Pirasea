extends CharacterBody2D

var speed = 110
var coin = preload("res://Scenes/coin.tscn")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
var boom = preload("res://Scenes/boom.tscn")
var enemygalleon = preload("res://Scenes/enemygalleon.tscn")
var enemyrammer = preload("res://Scenes/rammer.tscn")
var health = 250
var harpoon = false

func _ready():
	_make_path()
	$SpawnTimer.start(0.25)

func _physics_process(delta): 
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	if AutoloadScript.knockback == false: velocity = dir * speed
	if AutoloadScript.knockback == true: velocity = -(dir * speed)*1.5
	move_and_slide()
	
	
	if AutoloadScript.knockback == false:
		if velocity[0] > 0: 
			$Sprite2D.rotation = atan(velocity[1]/velocity[0]) + 1.5708
			$CollisionPolygon2D.rotation = atan(velocity[1]/velocity[0]) 
			$Area2D.rotation = atan(velocity[1]/velocity[0]) 
			$SpawnHandler.rotation = atan(velocity[1]/velocity[0]) 
			$HarpoonPoint.rotation = atan(velocity[1]/velocity[0]) 
		else: 
			$Sprite2D.rotation = atan(velocity[1]/velocity[0]) + 3.14159 + 1.5708
			$CollisionPolygon2D.rotation = atan(velocity[1]/velocity[0]) + 3.14159
			$Area2D.rotation = atan(velocity[1]/velocity[0]) + 3.14159
			$SpawnHandler.rotation = atan(velocity[1]/velocity[0]) + 3.14159
			$HarpoonPoint.rotation = atan(velocity[1]/velocity[0]) + 3.14159
	else:
		if velocity[0] > 0: 
			$Sprite2D.rotation = atan(velocity[1]/velocity[0]) + 1.5708 + 3.14159
			$CollisionPolygon2D.rotation = atan(velocity[1]/velocity[0]) + 3.14159
			$Area2D.rotation = atan(velocity[1]/velocity[0])  + 3.14159
			$SpawnHandler.rotation = atan(velocity[1]/velocity[0]) + 3.14159
			$HarpoonPoint.rotation = atan(velocity[1]/velocity[0]) + 3.14159
		else: 
			$Sprite2D.rotation = atan(velocity[1]/velocity[0]) + 1.5708
			$CollisionPolygon2D.rotation = atan(velocity[1]/velocity[0])
			$Area2D.rotation = atan(velocity[1]/velocity[0])
			$SpawnHandler.rotation = atan(velocity[1]/velocity[0]) 
			$HarpoonPoint.rotation = atan(velocity[1]/velocity[0]) 
	if harpoon == true:
		$HarpoonPoint/HarpoonHead.position.x += 10
		$HarpoonPoint/Chain.scale.y += 5.33
		$HarpoonPoint/Chain.position.x += 5.33
	else:
		if $HarpoonPoint/HarpoonHead.position.x > 203:
			$HarpoonPoint/HarpoonHead.position.x -= 10
		if $HarpoonPoint/Chain.scale.y > 1:
			$HarpoonPoint/Chain.scale.y -= 5.33
			$HarpoonPoint/Chain.position.x -= 5.33
	
func _make_path() -> void:
	nav_agent.target_position = get_node("/root/Main/Player").global_position

func _on_nav_timeout():
	_make_path() 

func _on_area_2d_area_entered(area):
	if "cannonball" in str(area).to_lower() or "boom" in str(area).to_lower():
		health -= 1
		if health <= 0:
			for i in range(20):
				var coininstance = coin.instantiate()
				get_node("/root/Main").add_child(coininstance)
				coininstance.name = "Coin"
				coininstance.global_position = self.global_position
			self.queue_free()

func _on_area_2d_body_entered(body):
	if $SpawnTimer.time_left > 0 and "island" in str(body).to_lower():
		self.position = AutoloadScript._choose_random_spawn()
		$SpawnTimer.start(0.25)

func _on_timer_timeout():
	show()
	
func _random_spawn():
	var spawnside = randi_range(1, 2)
	var spawn = Vector2(0.0, 0.0)
	if spawnside == 1:
		spawn = $SpawnHandler/Left.global_position
	if spawnside == 2:
		spawn = $SpawnHandler/Right.global_position
	return spawn

func _on_harpoon_timeout():
	harpoon = true
	await get_tree().create_timer(.5).timeout
	harpoon = false

func _on_harpoon_area_entered(area):
	if "player" in str(area).to_lower():
		harpoon = false
