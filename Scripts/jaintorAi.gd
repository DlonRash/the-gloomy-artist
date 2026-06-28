extends CharacterBody2D


@export var SPEED = 300.0
@export var cleaning_radius = 50.0

enum AiState {WANDER,CLEANING}
var current_state = AiState.WANDER

func _physics_process(delta):
	# need this to first ask if current postion is colored.
	var is_on_paint = PaintManager.is_position_painted(global_position, 20.0)
	
	match current_state:
		AiState.WANDER:
			velocity = Vector2.RIGHT * SPEED
			
			if is_on_paint:
				current_state = AiState.CLEANING
				print(" EWWWWW WHO MADE THIS SHIT GREY")
	
	move_and_slide()
