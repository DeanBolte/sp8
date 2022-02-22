extends KinematicBody2D

export (int) var MAX_VELOCITY = 650
export (int) var ACCELERATION = 2000
export (int) var JUMP_STRENGTH = 690
export (int) var WALL_JUMP_STRENGTH_X = 550
export (int) var WALL_JUMP_STRENGTH_Y = 400
export (int) var MINIMUM_WALL_VELOCITY = 50
export (int) var GRAVITY = 1800
export (float) var FRICTION_GROUND = 0.3
export (float) var FRICTION_AIR = 0.1
export (int) var WALLJUMP_LENIENCE = 2

var velocity = Vector2.ZERO
var hMoveModifier = 1
var windModifier = 0
var respawnLocation

func _ready():
	position = Manager.playerPosition
	
	respawnLocation = position

func _physics_process(delta):
	# move
	move_state(delta)
	
	# apply wind
	velocity.x += windModifier * delta
	
	# apply gravity
	velocity.y += GRAVITY * delta
	
	# apply velocity
	velocity = move_and_slide(velocity, Vector2.UP)

func move_state(delta):
	var move = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	# horizontal movement calculations
	if move != 0:
		velocity.x += move * ACCELERATION * delta
	
	# limit player velocity
	var current_max_velocity = hMoveModifier * MAX_VELOCITY
	velocity.x = clamp(velocity.x, -current_max_velocity, current_max_velocity)
	
	if is_on_floor():
		# floor effects
		# friction
		if move == 0 || sign(velocity.x) != sign(move):
			velocity.x = lerp(velocity.x, 0, FRICTION_GROUND)
		
		# jump
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -JUMP_STRENGTH
	else:
		# air effects
		# friction
		if move == 0 || sign(velocity.x) != sign(move):
			velocity.x = lerp(velocity.x, 0, FRICTION_AIR)
		
		# wall jump
		var dir = int(test_move(transform, Vector2(-WALLJUMP_LENIENCE, 0))) - int(test_move(transform, Vector2(WALLJUMP_LENIENCE, 0)))
		if dir != 0:
			if Input.is_action_just_pressed("ui_up"):
				velocity.y = -WALL_JUMP_STRENGTH_Y
				velocity.x = WALL_JUMP_STRENGTH_X * dir
		
		# slide down wall
		if is_on_wall():
			if velocity.y >= MINIMUM_WALL_VELOCITY:
				velocity.y = lerp(velocity.y, MINIMUM_WALL_VELOCITY, FRICTION_GROUND)
		
		# jump cancel
		if Input.is_action_just_released("ui_up") && velocity.y < -JUMP_STRENGTH/2:
			velocity.y = -JUMP_STRENGTH/2
	
	if Input.is_action_pressed("crouch"):
		$CollisionStanding.disabled = true
		$CollisionCrouched.disabled = false
		hMoveModifier = 0.4
		
	else:
		$CollisionStanding.disabled = false
		$CollisionCrouched.disabled = true
		hMoveModifier = 1

func _unhandled_input(event):
	if Input.is_action_just_pressed("rewind"):
		rewind_time()

func respawn():
	position = respawnLocation

func set_spawn(spawn_position):
	respawnLocation = spawn_position

func rewind_time():
	Manager.transition_zone("res://scenes/Zone0.tscn", Vector2(800, 1040))

func _on_RespawnDetector_area_entered(area):
	set_spawn(area.get_parent().position)

func _on_RoomDetector_area_entered(area):
	var camera = $Camera2D
	var collision_shape = area.get_node("CollisionShape2D")
	var room_size = collision_shape.shape.extents*2
	var view_size = get_viewport_rect().size
	
	# resize the camera zoom
	var zoomScale = room_size.x / view_size.x
	var zoomScaleAlt = room_size.y / view_size.y
	camera.set_zoom(Vector2(min(zoomScale, zoomScaleAlt), min(zoomScale, zoomScaleAlt)))
	
	# set the camera limits
	camera.limit_top = collision_shape.global_position.y - room_size.y/2
	camera.limit_left = collision_shape.global_position.x - room_size.x/2
	
	camera.limit_bottom = camera.limit_top + room_size.y
	camera.limit_right = camera.limit_left + room_size.x

func _on_KillZoneDetector_body_entered(_body):
	respawn()
