extends StaticBody2D

func open_door():
	$CollisionShape2D.disabled = true
	$Sprite.visible = true

func close_door():
	$CollisionShape2D.disabled = false
	$Sprite.visible = false

func toggle_door():
	$CollisionShape2D.disabled = !$CollisionShape2D.disabled
	$Sprite.visible = !$Sprite.visible
