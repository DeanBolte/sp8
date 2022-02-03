extends Node2D

var currentScene = "res://scenes/MainMenu.gd"

func change_scene(scene_path):
	get_tree().change_scene(scene_path)

func transition_zone(scene_path, player, new_position):
	change_scene(scene_path)
	player.position = new_position
