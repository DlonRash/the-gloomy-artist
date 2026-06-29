extends CharacterBody2D

@export var change_target_dist: float = 15.0
@export var SPEED = 300.0
@export var cleaning_radius = 50.0

enum AiState {WANDER,CLEANING}
var current_state = AiState.WANDER

var target_position: Vector2 = Vector2.ZERO
func _ready():
	await get_tree().process_frame
	set_new_random_target()
	
	
func _physics_process(delta):
	# need this to first ask if current postion is colored.
	var is_on_paint = PaintManager.is_position_painted(global_position, 20.0)
	
	match current_state:
		AiState.WANDER:
			velocity = Vector2.RIGHT * SPEED
			
			if is_on_paint:
				current_state = AiState.CLEANING
				velocity = Vector2.ZERO
				return	
			
			var direction = global_position.direction_to(target_position)
			velocity = direction * SPEED
			# If close to the target position, pick a new random spot
			if global_position.distance_to(target_position) < change_target_dist:
				set_new_random_target()
				
				#print(" EWWWWW WHO MADE THIS SHIT GREY")
			
		AiState.CLEANING:
			velocity = Vector2.ZERO
				
			if PaintManager.background_sprite:
					PaintManager.background_sprite.clean_paint_at_position(global_position, cleaning_radius)
					
			if not is_on_paint:
				current_state = AiState.WANDER
				print("Area clean! Resuming wander.")
	move_and_slide()

func set_new_random_target():
	var bg = PaintManager.background_sprite
	if not is_instance_valid(bg) or not bg.texture:
		return
	var tex_size = bg.texture.get_size()
	
	# Generate a random coordinate within the texture size boundaries
	# Offset by 50 pixels so the AI doesn't walk completely off the edges
	var random_x = randf_range(50.0, tex_size.x - 50.0)
	var random_y = randf_range(50.0, tex_size.y - 50.0)
	var local_target = Vector2(random_x, random_y)
	
	# Adjust if the background is set to "Centered" in the Inspector
	if bg.centered:
		local_target -= tex_size / 2.0
		
	# Convert the target from background coordinates to global world coordinates
	target_position = bg.to_global(local_target)
