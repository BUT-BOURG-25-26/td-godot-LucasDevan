class_name Player
extends CharacterBody3D
var healthbar
@export var move_speed:float = 5
@export var health: int = 5
@export var vfx_scene :PackedScene 

const damage_cool_downMax : float = 0.5
var damage_cool_down : float = 0.0

func _ready() -> void:
	healthbar = $SubViewport/HealthBar
	healthbar.max_value = health

func _process(delta:float) -> void:
	do_health_inputs()
	damage_cool_down-=delta

func _physics_process(delta: float) -> void:
	var move_inputs = read_move_inputs()
	#print(move_inputs)
	var _velocity = move_inputs * move_speed
	
	if(is_on_floor()):
		_velocity.y = Input.get_action_strength("jump") * 100 
	else:
		if(Input.get_action_strength("jump")>0):
			_velocity.y = get_gravity().y *delta/4
		else:
			_velocity.y = get_gravity().y *delta/2
	velocity = _velocity
	
	move_and_slide()
	return

func read_move_inputs() -> Vector3 :
	var move_inputs : Vector3
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	move_inputs.y = 0
	return move_inputs
	
func do_health_inputs() -> void :
	if Input.is_action_just_pressed("damage_player"):
		damage_player(1)
	if Input.is_action_just_pressed("heal_player"):
		heal_player(1)
	
func damage_player(amount : int =1):
	if(amount<0 || damage_cool_down>0):
		return
	health -= amount
	if(health<0):
		health=0
	var fx : ImpactVFX= vfx_scene.instantiate()
	add_child(fx)
	fx.global_position=global_position
	fx.global_position.y+=1
	fx.emit()
	healthbar.update(health)
	damage_cool_down = damage_cool_downMax
	
func heal_player(amount : int =1):
	if(amount<0):
		return
	health += amount
	if(health>healthbar.max_value):
		health=healthbar.max_value
	healthbar.update(health)
	
func get_health() -> int:
	return health
