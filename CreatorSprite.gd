extends Sprite

class_name CreatorSprite

# Declare member variables here. 
# Get the conway grid simulation Node
var global_par
var conway_sq_size

# Called when the node enters the scene tree for the first time.
func _ready():
	global_par = get_tree().get_root().get_node("Space/ConwayGrid")
	var node_par = get_parent()
	print("Creator ", node_par.name)
	# Scale the node to be the same size as a conway square
	conway_sq_size = global_par.size_sq
#	var sprite_size = texture.get_size()
#	#Transform.Scale.x = (conway_sq_size.x/sprite_size.x)
#	#Transform.Scale.y = (conway_sq_size.y/sprite_size.y)
#	print("Before scale transform ", node_par.position)
#	var scale_size = conway_sq_size/sprite_size
#	set_scale(conway_sq_size/sprite_size)
#	print("After scale transform ", node_par.position)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time_now = OS.get_ticks_msec()
