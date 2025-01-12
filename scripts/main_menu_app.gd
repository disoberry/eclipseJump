extends Node
var highscore_total 
@onready var high_score: Label = $CanvasLayer/MenuBackground/HighScore

func _ready() -> void:
	StaticMusic.play_music_level()
	high_score.text = "HIGHSCORE: 0"
	if FileAccess.file_exists(GlobalStates.save_path):
		var file = FileAccess.open(GlobalStates.save_path, FileAccess.READ)
		highscore_total = file.get_var(GlobalStates.highscore)
		high_score.text = "HIGHSCORE: " + str(highscore_total)


func _on_start_button_pressed() -> void:
	$".".visible = false
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()
