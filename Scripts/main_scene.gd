extends Node3D

@onready var player : Player = $"Player"

func _process(delta: float) -> void:
	if(player.get_health()==0):
		get_tree().reload_current_scene()
