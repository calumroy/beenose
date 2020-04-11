extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(ev):
	if ev is InputEventKey:
		if ev is InputEventKey and ev.scancode == KEY_RIGHT and not ev.echo:
			if ev.pressed:
				position.x += 10
		if ev is InputEventKey and ev.scancode == KEY_LEFT and not ev.echo:
			if ev.pressed:
				position.x += -10
