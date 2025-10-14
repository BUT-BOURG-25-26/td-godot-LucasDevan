extends Node3D

@onready var player : Player = $"Player"
@onready var GameOverMenu : Control = $CanvasLayer/GameOverMenue
func _process(delta: float) -> void:
	if(player.get_health()==0):
		GameManager.display_game_over()
