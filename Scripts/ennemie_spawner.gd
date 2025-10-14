class_name EnnemieSpawner
extends Node3D

#permet de référencer votre scène enemy au sein de votre script
@export var enemy_scene: PackedScene
const timerMax : float = 5.0
var timer : float 
var mainScene : Node3D
var spawn_position_list = []
var player : Player


func _ready() -> void:
	timer = timerMax
	player = $"../Player"
	mainScene = $".."
	spawn_position_list = [Vector3(-8,1,0),Vector3(8,1,0),Vector3(0,1,8),Vector3(0,1,-8)]

func _process(delta: float) -> void:
	if(timer>0):
		timer-=delta
	else:
		var enemy : Ennemie = enemy_scene.instantiate()
		mainScene.add_child(enemy)
		enemy.global_position = spawn_position_list[furthest_point_from_player()]
		timer = timerMax
		
func furthest_point_from_player() -> int:
	var maxDistance : float = 0 
	var selectedSpawn : int = 0
	for i in range(len(spawn_position_list)):
		#print( spawn_position_list.get(i))
		var currentDist = distance_with_player(spawn_position_list.get(i))
		#print(currentDist, " ",i)
		if(currentDist>maxDistance):
			maxDistance = currentDist
			selectedSpawn = i
	#print("selectedSpawn :",selectedSpawn)
	return selectedSpawn
	
func distance_with_player(spawn_position :  Vector3) -> float:
	var currentDist = 0
	var player_position = player.global_position
	currentDist += (spawn_position.x-player_position.x)**2 
	currentDist += (spawn_position.y-player_position.y)**2
	currentDist += (spawn_position.z-player_position.z)**2
		
	return sqrt(currentDist)
