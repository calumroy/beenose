extends Node2D


# Declare member variables here. Examples:
var right_pressed = false
# Get the conway grid simulation Node
var global_par
var last_update = 0.0
var num_creator_nodes = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	last_update = OS.get_ticks_msec()
	global_par = get_tree().get_root().get_node("Space/ConwayGrid")
	print("CWTool ", name)

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
				create_creator()
			
func create_creator():
	var new_position = get_global_mouse_position()
	var new_grid_pos = global_par.get_closest_grid(new_position)
	var node = Creator.new()
	var sprite = CreatorSprite.new()
	num_creator_nodes = num_creator_nodes + 1
	var creator_node_name = str("Creator", num_creator_nodes)
	print(creator_node_name)
	node.set_name(creator_node_name)
	global_par.add_child(node)
	node.add_child(sprite)
	node.position = new_grid_pos
	sprite.position = node.position
	sprite.texture = load("res://creator.png")
	
	

