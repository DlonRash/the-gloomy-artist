extends Label

func _process(_delta):
	text = "Unhappy Meter: " + str(PaintManager.current_score) + "%"
