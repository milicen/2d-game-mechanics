extends Camera2D

# var count = 0
var y_margin = 0
var x_margin
var character



func _ready():
	x_margin = get_viewport_rect().size.x / 2
	y_margin = get_viewport_rect().size.y / 2
	position = Vector2(x_margin, y_margin)
	character = get_parent().get_node("Character")

func _process(_delta):	
	x_margin = get_viewport_rect().size.x / 2
	y_margin = get_viewport_rect().size.y / 2
	
	var current_y = character.get_y_position()
	var current_x = character.get_x_position()
	
#	vp size test
#	print("os window size " + str(OS.window_size))
#	print("viewport rect size " + str(get_viewport_rect().size))
#	print("viewport_size" + str(get_viewport().size))

	# move camera position in y axis
	if(current_y < (position.y - y_margin)) :
		var new_camera_pos = Vector2(position.x, position.y - get_viewport_rect().size.y)
		position = new_camera_pos
		# count += 1
		return

	if(current_y > (position.y + y_margin)) :
		var new_camera_pos = Vector2(position.x, position.y + get_viewport_rect().size.y)
		position = new_camera_pos
		# count -= 1
		return

	# move camera position in x axis
	if(current_x < (position.x - x_margin)) :
		var new_camera_pos = Vector2(position.x - get_viewport().size.x, position.y)
		position = new_camera_pos
		# count += 1
		return

	if(current_x > (position.x + x_margin)) :
		var new_camera_pos = Vector2(position.x + get_viewport().size.x, position.y)
		position = new_camera_pos
		# count -= 1
		return
