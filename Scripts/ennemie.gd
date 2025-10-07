class_name Ennemie
extends CharacterBody3D

var player : Player
var speed : float = 2
func _ready() -> void:
	player = $"../Player"
	
func _physics_process(delta: float) -> void:
	var direction = player.global_position - global_position
	direction = direction.normalized()
	
	var look = player.global_position
	look.y = global_position.y
	look_at(look)
	
	velocity = direction * speed
	velocity.y = get_gravity().y
	
	move_and_slide()
