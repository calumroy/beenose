extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ind = 0

var grid_width = 10
var grid_height = 10
var size_sq = Vector2(64,64)
var life_update_period = 100.0 # milliseconds

# A dict of Vector2 of grid points x,y storing the number of active cells around the point.
var active_neighbours_count = {} 
var active_squares = [] # A Vector2 of grid points of active cells. 
var active_squares_dict = {} # A dictionary of Vector2 representing the active cells.

var left_pressed = false
var paused = false
var last_life_update = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	last_life_update = OS.get_ticks_msec()
	pass # Replace with function body.

func _process(delta):
	update()
	if left_pressed:
		add_active_square_at_mouse()
	if paused == false:
		var time_now = OS.get_ticks_msec()
		if (time_now - last_life_update) > life_update_period:
			last_life_update = OS.get_ticks_msec()
			conways_life_update()
		ind = ind+1
	
func _input(ev):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT:
			if ev.pressed:
				left_pressed = true
			else:
				left_pressed = false
	if ev is InputEventKey:
		if ev is InputEventKey and ev.scancode == KEY_SPACE and not ev.echo:
			if ev.pressed:
				if (paused == true):
					paused = false
				else:
					paused = true
			
			
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

func conways_life_update():
	# LIFE RULES:
	#     Any live cell with two or three neighbors survives.
	#     Any dead cell with three live neighbors becomes a live cell.
	#     All other live cells die in the next generation. 
	#     Similarly, all other dead cells stay dead.
	#
	# For each active cells in the active_cells list
	#	 For each one get the neighbours
	#	    For each neighbour
	#          Add it to the possible_active_cells list if not already present
	#          add one to their active_neighbours_count
	# 	 	   
	# For each cell in the possible_active_cells list
	# 	 If active_neighbours_count == 3
	#    	put in active cells if not there already
	#	 If (if active_neighbours_count == 2 and cell in active_cells):
	#		 keep in active cells
	#	 else:
	#		remove from active_cells
	#
	var possible_active_cells = []
	var new_active_sq_dict = {}
	active_squares = active_squares_dict.keys()
	active_neighbours_count = {}
	for i in range(active_squares.size()):
		var neighbours = []
		# Stored in order 11, 12, 13, 21, 22, 23, 31, 32, 33
		# [11,12,13,
		#  21,23,    // There is no 22 as this is the current cell
		#  31,32,33]
		neighbours.push_back(Vector2(active_squares[i].x - 1, active_squares[i].y - 1))
		neighbours.push_back(Vector2(active_squares[i].x    , active_squares[i].y - 1))
		neighbours.push_back(Vector2(active_squares[i].x + 1, active_squares[i].y - 1))
		neighbours.push_back(Vector2(active_squares[i].x - 1, active_squares[i].y))
		neighbours.push_back(Vector2(active_squares[i].x + 1, active_squares[i].y))
		neighbours.push_back(Vector2(active_squares[i].x - 1, active_squares[i].y + 1))
		neighbours.push_back(Vector2(active_squares[i].x    , active_squares[i].y + 1))
		neighbours.push_back(Vector2(active_squares[i].x + 1, active_squares[i].y + 1))
		
		for i in range(neighbours.size()):
			if active_neighbours_count.has(neighbours[i]):
				active_neighbours_count[neighbours[i]] += 1
			else:
				active_neighbours_count[neighbours[i]] = 1
				possible_active_cells.push_back(neighbours[i])
		
	for i in range(possible_active_cells.size()):	
		if active_neighbours_count[possible_active_cells[i]] == 3:
			new_active_sq_dict[possible_active_cells[i]] = true
		if ((active_neighbours_count[possible_active_cells[i]] == 2) and 
			(active_squares_dict.has(possible_active_cells[i]) == true)):
			new_active_sq_dict[possible_active_cells[i]] = true
	
	active_squares_dict = new_active_sq_dict	

func add_active_square_at_mouse():
	var new_position = get_global_mouse_position()
	var new_grid_pos = get_closest_grid(new_position)
	activate_square(new_grid_pos)
	
func add_creator_at_mouse():
	var new_position = get_global_mouse_position()
	var new_grid_pos = get_closest_grid(new_position)
	
	activate_square(new_grid_pos)

func get_closest_grid(new_position):
	var x_grid 
	var y_grid 
	if new_position.x < 0:
		x_grid = int(new_position.x / size_sq.x) - 1
	else:
		x_grid = int(new_position.x / size_sq.x)
	if new_position.y < 0:
		y_grid = int(new_position.y / size_sq.y) -1
	else:
		y_grid = int(new_position.y / size_sq.y)
	
	var grid_pos = Vector2(x_grid, y_grid)
	
	return grid_pos
	
func get_screen_pos(new_grid_pos):
	var x_screen = int(new_grid_pos.x * size_sq.x)
	var y_screen = int(new_grid_pos.y * size_sq.y)
	var screen_pos = Vector2(x_screen, y_screen)
	
	return screen_pos
	
func activate_square(new_grid_pos):
	# Add the new grid position to the array of active squares and the dictionary of squares
	# if it hasn't already been done.
	if not active_squares_dict.has(new_grid_pos):
		active_squares_dict[new_grid_pos] = true
		active_squares.push_back(new_grid_pos)

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
