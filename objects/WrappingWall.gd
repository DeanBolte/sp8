extends Node2D

onready var RightWall = $RightWall
onready var LeftWall = $LeftWall

var TELEPORT_OFFSET = 32

func _on_RightWall_body_entered(body):
	body.global_position.x = LeftWall.global_position.x + TELEPORT_OFFSET

func _on_LeftWall_body_entered(body):
	body.global_position.x = RightWall.global_position.x - TELEPORT_OFFSET
