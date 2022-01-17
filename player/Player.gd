extends KinematicBody2D

export (int) var MAX_VELOCITY = 700
export (int) var ACCELERATION = 2000
export (int) var JUMP_STRENGTH = 800
export (int) var WALL_JUMP_STRENGTH = 500
export (int) var MINIMUM_WALL_VELOCITY = 100
export (int) var GRAVITY = 800
export (float) var FRICTION_GROUND = 0.3
export (float) var FRICTION_AIR = 0.1

var velocity = Vector2.ZERO
var respawnLocation

func _ready():
	respawnLocation = position

func _physics_process(delta):
	# move
	move_state(delta)
	
	# gravity
	velocity.y += GRAVITY * delta
	
	# apply velocity
	velocity = move_and_slide(velocity, Vector2.UP)

func move_state(delta):
	var move = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	# horizontal movement calculations
	if move != 0:
		velocity.x += move * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_VELOCITY, MAX_VELOCITY)
	
	# air
	if is_on_floor():
		if move == 0:
			velocity.x = lerp(velocity.x, 0, FRICTION_GROUND)
		
		if Input.is_action_pressed("ui_up"):
			velocity.y = -JUMP_STRENGTH
	else:
		# wall jump
		if is_on_wall():
			if Input.is_action_just_pressed("ui_up"):
				velocity.y = -WALL_JUMP_STRENGTH
				velocity.x -= WALL_JUMP_STRENGTH * move
			
			# apply gravity
			if velocity.y <= MINIMUM_WALL_VELOCITY:
				velocity.y += GRAVITY * delta
		else:
			# apply gravity
			velocity.y += GRAVITY * delta
		
		if Input.is_action_just_released("ui_up") && velocity.y < -JUMP_STRENGTH/2:
			velocity.y = -JUMP_STRENGTH/2
		
		if move == 0:
			velocity.x = lerp(velocity.x, 0, FRICTION_AIR)

func respawn():
	position = respawnLocation

func _on_RespawnDetector_area_entered(area):
	respawnLocation = area.get_parent().position

func _on_KillZoneDetector_area_entered(area):
	respawn()
