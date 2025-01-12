extends Node2D



const fly_duration_scene = preload("res://scenes/fly_duration.tscn")

var player: CharacterBody2D
var world: Node2D

func _ready() -> void:
	player = get_tree().root.get_node("World/Player")
	world = get_tree().root.get_node("World")


func _process(delta: float) -> void:
	if global_position.y >= 800:
		world.pickup_exists = false
		queue_free()

func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body == player:
		if player.custom_gravitation.y == 980:
			var inst: = fly_duration_scene.instantiate()
			player.add_child(inst)
			world.pickup_exists = false
			queue_free()
		else:
			player.get_node("Fly_Duration").start()
			world.pickup_exists = false
			queue_free()
		
