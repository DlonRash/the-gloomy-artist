extends Node2D

var brush_size: float = 20.0
var points: Array[Vector2] = []

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var bg = PaintManager.background_sprite
		if bg:
			var pos = bg.to_local(get_global_mouse_position())
		# points back returns the last element of the array
			if points.is_empty() or points.back().distance_to(pos) > 2.0:
				points.append(pos)
				queue_redraw()
				PaintManager.update_score() 

func _draw():
	# paint white brush strokes over a black or transparent background
	for pt in points:
		draw_circle(pt, brush_size, Color.WHITE)
