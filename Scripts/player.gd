class_name Player
extends CharacterBody3D
var healthbar
@export var move_speed:float = 5
@export var health: int = 5

var move_inputs: Vector3
var gravity = 22

func _ready() -> void:
	healthbar = $SubViewport/HealthBar
	healthbar.max_value = health

func _process(delta:float) -> void:
	if Input.is_action_just_pressed("damage_player"):
		damage_player(1)
	if Input.is_action_just_pressed("heal_player"):
		heal_player(1)		

func _physics_process(delta: float) -> void:
	read_move_inputs()
	velocity = move_inputs * move_speed * delta
	
	if(is_on_floor()):
		velocity.y += Input.get_action_strength("jump")
	else :
		velocity.y -= get_gravity().y*delta
	move_and_slide()
	print(global_position)

	return

func read_move_inputs():
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	return
	
func damage_player(amount : int =1):
	health -= amount
	if(health<0):
		health=0
	healthbar.update(health)
	
func heal_player(amount : int =1):
	health += amount
	if(health>healthbar.max_value):
		health=healthbar.max_value
	healthbar.update(health)
	
func get_health() -> int:
	return health
