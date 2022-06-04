extends KinematicBody2D

export var GRAVITY = 1700
export var FRICTION = 0.3
export var MAX_VELOCITY = 2000
export var PLAYER_PUSH = 1000

var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.x = clamp(velocity.x, -MAX_VELOCITY, MAX_VELOCITY)
	velocity.x = lerp(velocity.x, 0, FRICTION)
	
	velocity.y += GRAVITY * delta
	
	velocity = move_and_slide(velocity)


func _on_PlayerDetector_body_entered(body):
	velocity.x += sign(global_position.x - body.global_position.x) * PLAYER_PUSH
