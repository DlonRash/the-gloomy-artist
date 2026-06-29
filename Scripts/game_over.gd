extends Control

@export var score_label: Label 

func _ready():
	if score_label:
		# Read the final score directly from the persistent manager
		score_label.text = "Final Monochrome Score: " + str(PaintManager.current_score) + "%"
	
	PaintManager.reset_for_next_run()


func _on_retry_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/MallScene.tscn") 


func _on_quit_button_button_down() -> void:
	get_tree().quit()
