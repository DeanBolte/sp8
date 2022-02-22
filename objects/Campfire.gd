extends Area2D

var activated = false

onready var SpawnPoint = $Spawn

func _physics_process(delta):
	if activated:
		$Sprite.rotate(PI * delta)

func _on_Campfire_body_entered(body):
	body.set_spawn(SpawnPoint.global_position)
	activated = true
