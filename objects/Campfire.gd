extends Area2D

var playerPresent = false
var Player = null

onready var SpawnPoint = $Spawn

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		if playerPresent:
			Player.set_spawn(SpawnPoint.global_position)

func _on_Campfire_body_entered(body):
	playerPresent = true
	Player = body

func _on_Campfire_body_exited(body):
	playerPresent = false
