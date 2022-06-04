extends StaticBody2D

export var DEFAULT_STATE = false

func open_door():
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite.visible = false

func close_door():
	$CollisionShape2D.set_deferred("disabled", false)
	$Sprite.visible = true

func toggle_door():
	$CollisionShape2D.set_deferred("disabled", !$CollisionShape2D.disabled)
	$Sprite.visible = !$Sprite.visible
