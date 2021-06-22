extends KinematicBody2D

export (int) var speed = 200
export (int) var jump_speed = -400
export (int) var gravity = 1000

var accumulated_jump_force = 0

var velocity = Vector2.ZERO

func get_input():
	if not is_on_floor():
		return
	velocity.x = 0
	if Input.is_action_pressed("right") && !Input.is_action_pressed("jump"):
		velocity.x += speed
	if Input.is_action_pressed("left") && !Input.is_action_pressed("jump"):
		velocity.x -= speed

func _physics_process(delta):
	get_input()
	
	jump_king_jump_mechanic(delta)

func jump_king_jump_mechanic(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

	if Input.is_action_pressed("jump"):
		accumulated_jump_force += delta 
		if Input.is_action_pressed("right"):
			velocity.x = speed
		if Input.is_action_pressed("left"):
			velocity.x = -speed
		
	if (Input.is_action_just_released("jump")  && is_on_floor()) || accumulated_jump_force >= 1:
		velocity.y = accumulated_jump_force * jump_speed
		
	if not is_on_floor():
		accumulated_jump_force = 0

func get_y_position():
	return position.y

func get_x_position():
	return position.x
