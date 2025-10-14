class_name ImpactVFX
extends Area3D 

@onready var flash = $Flash
@onready var sparks = $Sparks
@onready var shockwave = $Shockwave
@onready var flare = $Flare

func emit():
	flash.emitting = true
	flare.emitting = true
	shockwave.emitting = true
	sparks.emitting = true
	var ennemies = get_tree().get_nodes_in_group("ennemie")
	for i in range(len(ennemies)):
		if(ennemie_in_range(ennemies[i].global_position,1)):
			ennemies[i].queue_free()

func _on_shockwave_finished() -> void:
	queue_free()	
	
func ennemie_in_range(ennemies_position :  Vector3, range : float = 1) -> bool:
	var currentDist = 0
	currentDist += (ennemies_position.x-global_position.x)**2 
	currentDist += (ennemies_position.y-global_position.y)**2
	currentDist += (ennemies_position.z-global_position.z)**2
	return currentDist<range**2
	
func _on_body_entered(body: Node3D) -> void:
	print("entered")
	if(body is Ennemie):
		body.queue_free()
