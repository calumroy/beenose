extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ind = 0
var active_squares = [] # A Vector2 of grid points of active cells. 
var grid_width = 100
var grid_height = 100
var size_sq = Vector2(32,32)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	update()
	ind = ind+1
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			var new_position = get_global_mouse_position()
			var new_grid_pos = get_closest_grid(new_position)
			active_squares.push_back(new_grid_pos)
			
func _draw():
	var center = Vector2(ind, 200)
	var radius = 8
	var angle_from = 75
	var angle_to = 195
	var color = Color(1.0, 0.0, 0.0)
	for index in range(active_squares.size()):
		var rect = Rect2(get_screen_pos(active_squares[index]), size_sq)
		draw_rect ( rect, color, true, 1.0, false )
		
	#draw_square(center, radius, 1, color)
	#draw_circle_arc(center, radius, angle_from, angle_to, color)

func get_closest_grid(new_position):
	var x_grid = int(new_position.x / size_sq.x)
	var y_grid = int(new_position.y / size_sq.y)
	var max_x_grid = grid_height * size_sq.x
	var max_y_grid = grid_height * size_sq.y
	if x_grid > max_x_grid:
		x_grid = max_x_grid	
	if y_grid > max_y_grid:
		y_grid = max_y_grid	
	var grid_pos = Vector2(x_grid, y_grid)
	
	return grid_pos
	
func get_screen_pos(new_grid_pos):
	var x_screen = int(new_grid_pos.x * size_sq.x)
	var y_screen = int(new_grid_pos.y * size_sq.y)
	var screen_pos = Vector2(x_screen, y_screen)
	
	return screen_pos

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
		
func draw_square(center, radius, line_width, color):
	var points_sq = PoolVector2Array()
	points_sq.push_back(center + Vector2(-radius, -radius))
	points_sq.push_back(center + Vector2(radius, -radius))
	points_sq.push_back(center + Vector2(radius, radius))
	points_sq.push_back(center + Vector2(-radius, radius))
	points_sq.push_back(center + Vector2(-radius, -radius))
	
	for index_point in range(points_sq.size()-1):
		draw_line(points_sq[index_point], points_sq[index_point + 1], color)
