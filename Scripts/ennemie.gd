class_name Ennemie
extends CharacterBody3D

var player : Player
var speed : float = 2
var attack_cool_down : int = 0

func _ready() -> void:
	player = $"../Player"

func _process(delta: float) -> void:
	if(attack_cool_down<=0 && touches_player()):
		player.damage_player(1)
		#queue_free()
		attack_cool_down = 30
	attack_cool_down-=1

func _physics_process(delta: float) -> void:
	var direction = player.global_position - global_position
	direction = direction.normalized()
	
	var look = player.global_position
	look.y = global_position.y
	look_at(look)
	
	velocity = direction * speed
	velocity.y = get_gravity().y
		
	move_and_slide()
	#print("ennemie:",global_position)

func touches_player(action_range : float = 1.8)->bool:
	var vectorial_space_between = player.global_position - global_position
	var norme = vectorial_space_between.x**2 +vectorial_space_between.y**2 + vectorial_space_between.z**2
	if(norme>action_range):
		return false
	return true
