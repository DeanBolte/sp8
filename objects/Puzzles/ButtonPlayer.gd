extends Area2D

export (NodePath) var DOOR_PATH

var playerPresent = false

onready var Door = get_node(DOOR_PATH)

func _physics_process(delta):
	if playerPresent:
		$Sprite.rotate(PI * delta)

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		if playerPresent:
			Door.toggle_door()

func _on_Button_body_entered(_body):
	playerPresent = true

func _on_Button_body_exited(_body):
	playerPresent = false
