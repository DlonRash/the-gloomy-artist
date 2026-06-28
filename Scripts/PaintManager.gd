extends Node
var background_sprite: Sprite2D = null
var current_score: int = 0

func update_score():
	var paint_canvas = background_sprite.paint_canvas
	# make sure that the background is lowkirkly loaded
	if not background_sprite.texture:
		current_score = 0
		return
	
	
	#instead of getting different vector 2 i can extra the number directly as floats
	#var texture_size = background_sprite.texture.get_size()
	var tex_width: float = background_sprite.texture.get_width()
	var tex_height: float = background_sprite.texture.get_height()
	# gotta grab the total pixel area of the background## UPDATE: grabs the new float variable 
	#var total_area = texture_size.x * texture_size.y
	var total_area = tex_width * tex_height
	
	# guard check
	if total_area <= 0.0:
		current_score = 0
		return
	
	var brush_size = paint_canvas.get("brush_size")  if "brush_size" in paint_canvas else 20.0
	## calculating approximate area covered by a single brush stroke circle
	var stroke_area = PI * (brush_size * brush_size)
	# multipy by toital points drawn
	var total_drawn_points: float = paint_canvas.points.size()
	var estimated_painted_area: float = total_drawn_points * stroke_area
	
	# calculate percentagea (0 to 100)
	var coverage_percentage = (estimated_painted_area / total_area) * 100.0
	#var final_percentage = clamp(coverage_percentage, 0.0, 100.0)
	# making the clamp myself to avoid errors with the godot built in one.
	if coverage_percentage > 100.0:
		coverage_percentage = 100.0
	elif coverage_percentage < 0.0:
		coverage_percentage = 0.0
	
	# wrapping it all up by converting it into a float/int
	current_score = int(coverage_percentage)
	
func is_position_painted(global_pos: Vector2, radius: float = 15.0) -> bool:
	if not is_instance_valid(background_sprite) or not is_instance_valid(background_sprite.paint_canvas):
		#print("NO BACKGROUND HERE")
		return false

# need to find the paintcanvas child node.

	var paint_canvas = background_sprite.paint_canvas
	#if not paint_canvas:
		#print("Cant find the sprite here!")
		#return false
		
	# tweaked this to convert global postions to the background texture cordinate space: should account for unaccounted for sprite editing to crash it
	#var local_pos = paint_canvas.to_local(global_pos)
	var local_pos = background_sprite.to_local(global_pos)
	
	if background_sprite.centered:
		local_pos += background_sprite.texture.get_size() /2.0 #?
		

	for pt in paint_canvas.points:
		if pt.distance_to(local_pos) < radius:
			#print("DING DING IT HEREE")
			return true
	#print("no points detected False as FUCCKK")
	return false
