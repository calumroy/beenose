extends Node2D


# Declare member variables here.
var global_par
var right_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	global_par = get_tree().get_root().get_node("Space/ConwayGrid") 	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(ev):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_RIGHT:
			if ev.pressed:
				right_pressed = true
			else:
				right_pressed = false
				create_block()


func create_block():
	#spawn a new creator block
	var creator_block = load("res://CreatorBlock/CreatorBlock.tscn")
	var new_creator_block = creator_block.instance()
	# Set the position to the current mouse position
	var new_position = get_global_mouse_position()
	var new_grid_pos = global_par.get_closest_grid(new_position)
	# Convert from closest grid pos back to screen position to lace the block
	var new_screen_pos = global_par.get_screen_pos(new_grid_pos)
	new_creator_block.position = new_screen_pos
	add_child_below_node(global_par, new_creator_block)
	
