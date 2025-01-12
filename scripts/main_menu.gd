extends Node


func _ready() -> void:
	pass


func _input(event):
	if event.is_action_pressed("ui_accept"):
		if $".".visible == true:
			get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_start_button_pressed() -> void:
	$".".visible = false
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
