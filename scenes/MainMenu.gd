extends Control

export var NO_ITEMS = 3

var menuItemSelected = 0

var font32res = "res://assets/fonts/vgatype_sans_32.tres"
var font64res = "res://assets/fonts/vgatype_sans_64.tres"

onready var MenuItems = get_node("VBoxContainer/MenuItems")

func _ready():
	# set up the first frame of the menu
	moveSelector(0)

func _unhandled_input(_event):
	if Input.is_action_just_pressed("ui_down"):
		moveSelector(1)
	if Input.is_action_just_pressed("ui_up"):
		moveSelector(-1)
	if Input.is_action_just_pressed("ui_accept"):
		useMenuItem()

func moveSelector(move):
	menuItemSelected += move
	if menuItemSelected < 0:
		menuItemSelected = NO_ITEMS - 1
	elif menuItemSelected >= NO_ITEMS:
		menuItemSelected = 0
	
	for i in range(NO_ITEMS):
		var MenuItem = MenuItems.get_child(i)
		if i == menuItemSelected:
			MenuItem.size_flags_stretch_ratio = 2
			MenuItem.add_font_override("font", load(font64res))
		else:
			MenuItem.size_flags_stretch_ratio = 1
			MenuItem.add_font_override("font", load(font32res))

func useMenuItem():
	match menuItemSelected:
		0: # Play
			get_tree().change_scene("res://scenes/Zone0.tscn")
		1: # Options
			pass
		2: # Exit
			get_tree().quit()
