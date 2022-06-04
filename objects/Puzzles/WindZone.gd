extends Area2D

export var WIND_SPEED = 500

func _on_WindZone_body_entered(body):
	body.windModifier = WIND_SPEED

func _on_WindZone_body_exited(body):
	body.windModifier = 0
