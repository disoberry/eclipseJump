extends Timer

var player: CharacterBody2D
var animation_player_node: AnimationPlayer

func _ready() -> void:
	player = get_tree().root.get_node("World/Player")
	player.JUMP_VELOCITY *= 2.0
	animation_player_node = get_tree().root.get_node("World/Player/AnimationPlayer")
	animation_player_node.play("change_to_bunny")


func _on_timeout() -> void:
	player.JUMP_VELOCITY /= 2
	queue_free()
	animation_player_node.play_backwards("change_to_bunny")
