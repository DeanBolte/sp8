extends ColorRect

onready var AnimPlayer = $AnimationPlayer

func _ready():
	# move to player
	rect_position = get_node("../Player").global_position - Vector2(600, 400)
	
	# play animation
	AnimPlayer.play_backwards("Fade")
