class_name Ennemie
extends CharacterBody3D

var player : Player
var speed : float = 2
func _ready() -> void:
	player = $"../Player"
var attack_cool_down : int = 0

func _physics_process(delta: float) -> void:
	var direction = player.global_position - global_position
	direction = direction.normalized()
	
	var look = player.global_position
	look.y = global_position.y
	look_at(look)
	
	velocity = direction * speed
	velocity.y = get_gravity().y
		
	if(attack_cool_down<=0 && touches_player()):
		player.damage_player(1)
		attack_cool_down = 30
		
	attack_cool_down-=1
	
	move_and_slide()

func touches_player()->bool:
	var vectorial_space_between = player.global_position - global_position
	var norme = sqrt(vectorial_space_between.x**2 +vectorial_space_between.y**2 + vectorial_space_between.z**2)
	if(norme>=1):
		return false
	return true
