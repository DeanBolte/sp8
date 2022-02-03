extends Area2D

export var TRANSITION_TO = "res://scenes/Zone1.tscn"
export var NEW_POSITION = Vector2(0, 0)

func _on_Transition_body_entered(body):
	Manager.transition_zone(TRANSITION_TO, body, NEW_POSITION)
