extends CharacterBody2D

var speed = 50
@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _ready():
	_make_path()

func _physics_process(delta): 
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	
func _make_path() -> void:
	nav_agent.target_position = get_node("/root/Main/Player").global_position

func _on_timer_timeout():
	_make_path() 
