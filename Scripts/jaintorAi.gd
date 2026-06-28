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
			
		AiState.CLEANING:
			velocity = Vector2.ZERO
				
			if PaintManager.background_sprite:
					PaintManager.background_sprite.clean_paint_at_position(global_position, cleaning_radius)
					
			if not is_on_paint:
				current_state = AiState.WANDER
				print("Area clean! Resuming wander.")
	move_and_slide()
