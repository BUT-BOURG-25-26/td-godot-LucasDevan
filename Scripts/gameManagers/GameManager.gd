extends Node

var ennemiesKilled : int =0

func display_game_over():
	get_tree().get_first_node_in_group("game_over").visible = true
	Engine.time_scale=0.0

func increase_ennemies_killed():
	ennemiesKilled +=1
	var ennemiesKilledLable : Label = get_tree().get_first_node_in_group("ennemiesKilled")
	ennemiesKilledLable.text = "Kills : "+str(ennemiesKilled)
	
func restart():
	get_tree().reload_current_scene()
	Engine.time_scale=1.0

func quite():
	get_tree().quit()
