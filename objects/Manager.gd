extends Node2D

var currentScene = "res://scenes/MainMenu.gd"
var playerPosition = Vector2(0, 0)

func change_scene(scene_path):
	change_scene_to(load(scene_path))

func change_scene_to(scene):
	get_tree().change_scene_to(scene)

func transition_zone(scene_path, new_position):
	# change scene
	change_scene(scene_path)
	
	# store players new position
	playerPosition = new_position

func move_player(new_position):
	var player = get_node("/root/Zone0/Player")
	player.position = new_position
