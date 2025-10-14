extends Node3D

@export var vfx_scene: PackedScene

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		# Récupère la caméra dans la scène
		var camera = get_viewport().get_camera_3d()
		if(camera):
			# Permet de convertir la position 2D en position de départ 3D & d'arrivée 3D
			var screen_pos = get_viewport().get_mouse_position()
			
			var from = camera.project_ray_origin(screen_pos)
			var to = from + camera.project_ray_normal(screen_pos) * 1000.0
			# Permet de récupérer l'espace du world actuel pour créer un raycast
			var space_state = get_world_3d().direct_space_state
			var query = PhysicsRayQueryParameters3D.create(from, to)
			# La fonction qui permet vraiment de savoir avec quoi on collisionne
			var result = space_state.intersect_ray(query)
			if result:
				var fx : ImpactVFX = vfx_scene.instantiate()
				add_child(fx)
				fx.global_position = result.position
				fx.emit()
	elif event is InputEventMouseMotion:
		print("Mouse Motion at: ", event.position)
