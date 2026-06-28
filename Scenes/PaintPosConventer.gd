extends Sprite2D
@export var paint_canvas : Node2D

func _ready():
	
	# trying to register the background globally so it can be found. BLEHHHH
	# adding this to try aand keep the game from booting up to get reference to viewport.
	
	await get_tree().process_frame
	PaintManager.background_sprite = self
	
func clean_paint_at_position(global_erase_pos: Vector2, erase_radius: float):
	
	var local_pos = to_local(global_erase_pos)
	
	if centered:
		local_pos += texture.get_size() / 2.0
	# erase points withjin the cleaning brush radius
	for i in range(paint_canvas.points.size()-1, -1, -1): 
		if paint_canvas.points[i].distance_to(local_pos) < erase_radius:
			paint_canvas.points.remove_at(i)

	paint_canvas.queue_redraw()
	PaintManager.update_score() # updates whenever the ai cleans
	
	
	
