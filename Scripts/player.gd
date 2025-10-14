class_name Player
extends CharacterBody3D
var healthbar
@export var move_speed:float = 5
@export var health: int = 5

var vfx_scene :ImpactVFX 
const damage_cool_downMax : float = 0.5
var damage_cool_down : float = 0.0

func _ready() -> void:
	healthbar = $SubViewport/HealthBar
	healthbar.max_value = health
	vfx_scene = $ImpactVFX

func _process(delta:float) -> void:
	do_health_inputs()
	damage_cool_down-=delta
		

func _physics_process(delta: float) -> void:
	var move_inputs = read_move_inputs()
	#print(move_inputs)
	var _velocity = move_inputs * move_speed
	
	if(is_on_floor()):
		_velocity.y += Input.get_action_strength("jump") * 100 
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
	vfx_scene.emit()
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

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		# Récupère la caméra dans la scène
		var camera = get_viewport().get_camera_3d()
		if(camera):
			# Permet de convertir la position 2D en position de départ 3D & d'arrivée 3D
			var from = camera.project_ray_origin(event.position)
			var to = from + camera.project_ray_normal(event.position) * 1000.0
			# Permet de récupérer l'espace du world actuel pour créer un raycast
			var space_state = get_world_3d().direct_space_state
			var query = PhysicsRayQueryParameters3D.create(from, to)
			# La fonction qui permet vraiment de savoir avec quoi on collisionne
			var result = space_state.intersect_ray(query)
			if result:
				#var fx : ImpactVFX = vfx_scene.instantiate()
				#fx.emit()
				print(result.position)
	elif event is InputEventMouseMotion:
		print("Mouse Motion at: ", event.position)

	# Print the size of the viewport.
	#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
