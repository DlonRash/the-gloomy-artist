extends Sprite2D
@export var paint_canvas : Node2D

@onready var clean_timer: Timer = $"../jaintor/Clean_Label2/Clean_Timer"
@onready var clean_label: Label = $"../jaintor/Clean_Label2"

@onready var level_timer: Timer = $"../Level_Timer"
@onready var level_time_lable: Label = $"../CanvasLayer/VBoxContainer/Level_Time_Lable"


var Start_Button = false
var currently_cleaning = false
var game_over = false

func _ready():
	level_timer.start()
	level_time_lable.text = str(int(level_timer.time_left))
	game_over = false
	# trying to register the background globally so it can be found. BLEHHHH
	# adding this to try aand keep the game from booting up to get reference to viewport.
	
	await get_tree().process_frame
	PaintManager.background_sprite = self
	
func clean_paint_at_position(global_erase_pos: Vector2, erase_radius: float):
	
	clean_label.text = str(clean_timer.time_left)
	
	if not currently_cleaning and not Start_Button:
		currently_cleaning = true
		clean_timer.start()
		return
		
	if Start_Button:
		
		var local_pos = to_local(global_erase_pos)
		
		if centered:
			local_pos += texture.get_size() / 2.0
		# erase points withjin the cleaning brush radius
		for i in range(paint_canvas.points.size()-1, -1, -1): 
			if paint_canvas.points[i].distance_to(local_pos) < erase_radius:
				paint_canvas.points.remove_at(i)
		var is_on_paint = PaintManager.is_position_painted(global_erase_pos, erase_radius)
		
		if not is_on_paint:
			Start_Button = false
			currently_cleaning = false

		paint_canvas.queue_redraw()
		PaintManager.update_score() # updates whenever the ai cleans
	
	
	
func _process(delta):
	# ending the game and switcning to game over scene
	if game_over:
		#PaintManager.clear_references()
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	level_time_lable.text = str(int(level_timer.time_left))
	
	if not clean_timer.is_stopped():
		clean_label.text = str(int(clean_timer.time_left))
	else:
		clean_label.text = "0"



func _on_clean_timer_timeout():
	Start_Button = true
	

func _on_level_timer_timeout():
	game_over = true
