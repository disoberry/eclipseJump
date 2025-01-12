extends Timer

var player: CharacterBody2D
var animation_player_node: AnimationPlayer
var player_sprite: Sprite2D


func _ready() -> void:
	player = get_tree().root.get_node("World/Player")
	player.custom_gravitation.y = 0
	animation_player_node = get_tree().root.get_node("World/Player/AnimationPlayer")
	animation_player_node.play("flying_hero")
	player_sprite = get_tree().root.get_node("World/Player/PlayerSprite")
func _process(delta) -> void:
	player.velocity.y = -800


func _on_timeout() -> void:
	player.custom_gravitation.y = 980
	animation_player_node.stop()
	player_sprite.frame = 0
	queue_free()
