extends Node2D

var texture_number: = [1, 1, 1, 2, 1]

var platform_count_texture: = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var varias = 1
	if varias == 1:
		$PlatformCollision/Sprite2D.texture = load("res://assets/platform1.png")
	elif varias == 2:
		$PlatformCollision/Sprite2D.texture = load("res://assets/platform2.png")
