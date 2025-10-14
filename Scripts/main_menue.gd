extends CanvasLayer


func _on_play_button_pressed() -> void:
	GameManager.restart()

func _on_quite_button_pressed() -> void:
	GameManager.quite()
