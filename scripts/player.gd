extends CharacterBody2D

@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var player_object: CharacterBody2D = $"."

@onready var width: = get_viewport_rect().size.x
@onready var height: = get_viewport_rect().size.y


const SPEED = 400.0
var JUMP_VELOCITY = -730.0

var custom_gravitation = Vector2(0, 980)

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += custom_gravitation * delta
		
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AudioStreamPlayer2D.play()

	if player_object.position.x > width:
		player_object.position.x = 1
	elif player_object.position.x < 0:
		player_object.position.x = 599
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.x >= 0:
			player_sprite.flip_h = false
			$Sprite2D.flip_h = false
		else:
			player_sprite.flip_h = true
			$Sprite2D.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
