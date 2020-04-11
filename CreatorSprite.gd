extends Sprite


# Declare member variables here. 
var creator_period = 2000.0 # milliseconds
var last_update = 0.0
var ind = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	last_update = OS.get_ticks_msec()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time_now = OS.get_ticks_msec()
	if (time_now - last_update) > creator_period:
		last_update = OS.get_ticks_msec()
#		create_cw_inputs()
	ind = ind+1


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(ev):
	if ev is InputEventKey:
		if ev is InputEventKey and ev.scancode == KEY_RIGHT:
			if ev.pressed:
				position.x += 10
		if ev is InputEventKey and ev.scancode == KEY_LEFT:
			if ev.pressed:
				position.x += -10
		if ev is InputEventKey and ev.scancode == KEY_DOWN:
			if ev.pressed:
				position.y += 10
		if ev is InputEventKey and ev.scancode == KEY_UP:
			if ev.pressed:
				position.y += -10

#func create_cw_inputs():
#	var global_par = get_tree().get_root().get_node("Space/ConwayGrid") # get_node(“/root/Root”) # get_parent()  #.get_node("Creator")
#	global_par.
#	var ConwayGrid #.position= mynewposition
