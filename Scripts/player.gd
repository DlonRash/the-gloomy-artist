extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var move_speed : float = 100


func _physics_process(_delta):
	# get input direction
	var input_direction = Vector2(
	Input.get_action_strength("direction_Right") - Input.get_action_strength("direction_Left"),
	
	Input.get_action_strength("direction_Down") - Input.get_action_strength("direction_Up")
	
	)
	velocity = input_direction * move_speed
	move_and_slide()
