extends Node


@export var test_music: AudioStream
@export var entry_scene: PackedScene
# var title_scene_loaded: bool = false
# var gameplay_loaded: bool = false
# var cur = 0

# var is_paused: bool = false

func _ready() -> void:
	Global.game_manager = self	
	# Global.score = 0

	$"Screen Fade/AnimationPlayer".play("RESET")
	Global.audio_manager.play_music(test_music)
	var entry_scene_instance = Global.scene_manager.load_scene_from_resource(entry_scene, false)
	$Game.add_child(entry_scene_instance)


func _process(_delta: float) -> void:
	# if title_scene_loaded and Input.is_action_just_pressed("Start") and not gameplay_loaded:
	# 	Global.audio_manager.stop_music()
	# 	$"UI/HighScoreText".hide()
	# 	$"Screen Fade/AnimationPlayer".play("Fade")
	# 	await $"Screen Fade/AnimationPlayer".animation_finished
	# 	$"Screen Fade/AnimationPlayer".play_backwards("Fade")
	# 	var gameplay_scene_instance = Global.scene_manager.load_scene("res://Scenes/Gameplay.tscn", true)
	# 	Global.audio_manager.play_music(Global.gameplay_theme_dmg)
	# 	$SubViewport.add_child(gameplay_scene_instance)
	# 	await $"Screen Fade/AnimationPlayer".animation_finished
	# 	$"UI/GameplayText".text = str("Ready?")
	# 	await get_tree().create_timer(1).timeout
	# 	$"UI/GameplayText".hide()
	# 	gameplay_loaded = true
	
	# if gameplay_loaded:
	# 	$UI/ScoreText.text = str(Global.score)
	# 	$UI/LivesText.text = str("*", Global.player.lives)

	# 	# Handle Pausing
	# 	if Input.is_action_just_pressed("Pause") and is_paused == false:
	# 		$"UI/GameplayText".text = str("Paused")
	# 		$"UI/GameplayText".show()
	# 		Engine.time_scale = 0
	# 		is_paused = true
	# 	elif Input.is_action_just_pressed("Pause") and is_paused == true:
	# 		$"UI/GameplayText".hide()
	# 		Engine.time_scale = 1
	# 		is_paused = false

	# 	if Global.player.is_dead:
	# 		$"UI/GameplayText".text = str("Game Over")
	# 		$"UI/GameplayText".show()
	# 		Global.high_score = Global.score
	# 		await get_tree().create_timer(5).timeout
	# 		Global.splash_done = true
	# 		get_tree().reload_current_scene()
	
	#print(Global.score)

	pass

# func clear_screen() -> void:
# 	if gameplay_loaded:
# 		for node in $SubViewport/Gameplay/EnemySpawner/Enemies.get_children():
# 			node.queue_free()
