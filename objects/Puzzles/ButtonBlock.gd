extends Area2D

export (NodePath) var DOOR_PATH

var blockPresent = false

onready var Door = get_node(DOOR_PATH)

func _physics_process(delta):
	if blockPresent:
		$Sprite.rotate(PI * delta)
		Door.open_door()

func _on_BlockButton_body_entered(body):
	blockPresent = true

func _on_BlockButton_body_exited(body):
	blockPresent = false
	Door.close_door()
