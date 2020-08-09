extends Node2D
class_name Creator

# Declare member variables here. 
var creator_period = 2000.0 # milliseconds
var last_update = 0.0
var ind = 0
# Get the conway grid simulation Node
var global_par
var conway_sq_size

# Called when the node enters the scene tree for the first time.
func _ready():
	last_update = OS.get_ticks_msec()
	global_par = get_tree().get_root().get_node("Space/ConwayGrid")
	print("Creator ", name)
	# Scale the node to be the same size as a conway square
	conway_sq_size = global_par.size_sq
	# Set the position to the same position as a conway square.
	print("Before pos transform ", position)
#	position = Vector2(round(position.x / conway_sq_size.x), 
#					   round(position.y / conway_sq_size.y))
	print("Afer pos transform", position)
	
func _process(delta):
	var time_now = OS.get_ticks_msec()
	if (time_now - last_update) > creator_period:
		last_update = OS.get_ticks_msec()
		create_cw_inputs()
	ind = ind+1

func _input(ev):
	if ev is InputEventKey:
		if ev is InputEventKey and ev.scancode == KEY_RIGHT:
			if ev.pressed:
				position.x += conway_sq_size.x
		if ev is InputEventKey and ev.scancode == KEY_LEFT:
			if ev.pressed:
				position.x += -conway_sq_size.x
		if ev is InputEventKey and ev.scancode == KEY_DOWN:
			if ev.pressed:
				position.y += conway_sq_size.y
		if ev is InputEventKey and ev.scancode == KEY_UP:
			if ev.pressed:
				position.y += -conway_sq_size.y

func create_cw_inputs():
	 # get_node(“/root/Root”) # get_parent()  #.get_node("Creator")
	print(position)
	var new_pos_topleft = position 
	var new_grid_pos = global_par.get_closest_grid(new_pos_topleft)
	
	global_par.activate_square(new_grid_pos)
#	var ConwayGrid #.position= mynewposition
