extends Button


func _on_try_again_button_pressed():
	# This automatically boots up a brand-new background, canvas, and janitor AI
	get_tree("res://Scenes/MallScene.tscn") # Change to your gameplay file path
