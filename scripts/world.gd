extends Node2D

@onready var width: = get_viewport_rect().size.x
@onready var height: = get_viewport_rect().size.y

@onready var bomb: Node2D = $Bomb


var platform: = preload("res://scenes/platform.tscn")
var pickup: = preload("res://scenes/pickup.tscn")
var pickup_fly = preload("res://scenes/pickup_fly.tscn")

var pickup_position: Vector2

var player_dead = false


var platformCount: int = 4

@onready var fake_platform: Node2D = $FakePlatform

@onready var pick_up_timer: Timer = $PickUpTimer
@onready var pickups: Node2D = $Pickups
@onready var player: = $Player
@onready var platformParent: = $Platforms
@onready var background: Sprite2D = $"ParallaxBackground/ParallaxLayer/Sprite2D"
@onready var user_interface: Control = $UserInterface

var score_height = 0

@onready var treshold: = height * 0.5

var pickup_exists = false

var platforms: = []

var pickups_table: = []

var scrollSpeed = 0.05



func _ready()->void:
	
	StaticMusic.play_music_level()
	
	bomb.global_position.x = randi_range(10, 590)
	fake_platform.global_position.x = randi_range(10, 590)
	fake_platform.global_position.y = 100
	
	
	player.global_position.y = treshold
	for i in platformCount:
		var inst: = platform.instantiate()
		inst.global_position.y = height / platformCount * i
		inst.global_position.x = rand_x()
		platformParent.add_child(inst)
		platforms.append(inst)
	#safety net - put lowest platform under player
	player.global_position.x = rand_x()
	platforms.back().global_position.x = player.global_position.x

func rand_x()->float:
	return randf_range(28.0, width-28.0)

func _physics_process(delta:float)->void:
	if !player_dead:
		 
		
		
		
		if pickups.get_child_count() > 0:
			pickup_exists = true
		else: 	
			pickup_exists = false
		
		if player.global_position.y < treshold:
			var move:float = lerp(0.0, treshold -player.global_position.y, scrollSpeed)
			move_background(move)
			player.global_position.y += move
			fake_platform.global_position.y += move
			bomb.global_position.y += move
			
			for pick in pickups_table:
				
				if pick != null:
					pick.global_position.y += move
			
			if bomb.global_position.y > height:
				bomb.global_position.y -= height + 100
				bomb.global_position.x = randi_range(10, width-10)
			
			if fake_platform.global_position.y > height:
				fake_platform.global_position.y -= height + 200
				fake_platform.global_position.x = randi_range(10, width-10)
				$FakePlatform/PlatformCollision/Fake22.frame = 0
				$FakePlatform/AnotherArea/Area2D/CollisionShape2D.disabled = false
				$FakePlatform/AnotherArea.visible = true
				
			for plat in platforms:
				plat.global_position.y += move
				if plat.global_position.y > height:
					plat.global_position.y -= height
					plat.global_position.x = rand_x()
					score_height += 1
					user_interface.get_node("CanvasLayer/Distance").text = var_to_str(score_height)
		

		
		if player.global_position.y > height:
			game_over()

func move_background(move:float)->void:
	var ratio: = 0.75
	background.global_position.y = fmod((background.global_position.y +height +move*ratio), height) - height

func game_over()->void:
	if score_height > GlobalStates.highscore:
		GlobalStates.highscore = score_height
	$PlayerLostScreen.show()
	$PlayerLostScreen/Control/HighScore.text = str(score_height)
	player_dead = true
	
	var file = FileAccess.open(GlobalStates.save_path, FileAccess.WRITE)
	file.store_var(GlobalStates.highscore)
	#get_tree().reload_current_scene()


func _on_pick_up_timer_timeout() -> void:
	if pickup_exists == false:
		var inst
		if randi_range(1, 2) == 1:
			inst = pickup.instantiate()
		else:
			inst = pickup_fly.instantiate()
		inst.global_position.y = 10
		inst.global_position.x = rand_x()
		pickups.add_child(inst)
		pickups_table.append(inst)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		player_dead = true
		$AnimationExp.play("bomb_explosion")


func _on_area_fake_body_entered(body: Node2D) -> void:
	if body == player:
		$FakePlatformAnimation.play("fake_destroying")

func call_deffered_hiding_area():
	$FakePlatform/AnotherArea/Area2D/CollisionShape2D.call_deferred("set_visible", false)
	$FakePlatform/AnotherArea.call_deferred("set_visible", false)

func call_deffered_move_out_of_scene():
	$FakePlatform.call_deferred("move_local_x", 1200)
