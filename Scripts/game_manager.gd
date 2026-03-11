extends Node

var title_scene_loaded: bool = false
var gameplay_loaded: bool = false
var cur = 0

var is_paused: bool = false

func _ready() -> void:
	Global.game_manager = self	
	Global.score = 0

	$"Screen Fade/AnimationPlayer".play("RESET")

	if not Global.splash_done:
		var splash_graphic = Sprite2D.new()
		$SubViewport.add_child(splash_graphic)
		splash_graphic.position = Vector2(160 / 2, 144 / 2)
		splash_graphic.texture = load("res://Graphics/Splash/glacie_games_splash.png")
		AudioManager.play_sfx(Global.splash_sfx)
		$"Screen Fade/AnimationPlayer".play_backwards("Fade")
		await get_tree().create_timer(1.5).timeout
		$"Screen Fade/AnimationPlayer".play("Fade")
		await $"Screen Fade/AnimationPlayer".animation_finished
		splash_graphic.texture = load("res://Graphics/Splash/godot_splash.png")
		$"Screen Fade/AnimationPlayer".play_backwards("Fade")
		await get_tree().create_timer(1.5).timeout
		$"Screen Fade/AnimationPlayer".play("Fade")
		await $"Screen Fade/AnimationPlayer".animation_finished
		splash_graphic.queue_free()
		Global.splash_done = true




	if Global.splash_done and not title_scene_loaded:
		$"Screen Fade/AnimationPlayer".play_backwards("Fade")
		Global.audio_manager.play_music(Global.title_theme_dmg)
		var title_scene_instance = Global.scene_manager.load_scene("res://Scenes/Menus/Title.tscn", false)
		$SubViewport.add_child(title_scene_instance)
		title_scene_loaded = true

		$"UI/HighScoreText".text = str("High Score:", Global.high_score)


func _process(_delta: float) -> void:
	if title_scene_loaded and Input.is_action_just_pressed("Start") and not gameplay_loaded:
		Global.audio_manager.stop_music()
		$"UI/HighScoreText".hide()
		$"Screen Fade/AnimationPlayer".play("Fade")
		await $"Screen Fade/AnimationPlayer".animation_finished
		$"Screen Fade/AnimationPlayer".play_backwards("Fade")
		var gameplay_scene_instance = Global.scene_manager.load_scene("res://Scenes/Gameplay.tscn", true)
		Global.audio_manager.play_music(Global.gameplay_theme_dmg)
		$SubViewport.add_child(gameplay_scene_instance)
		await $"Screen Fade/AnimationPlayer".animation_finished
		$"UI/GameplayText".text = str("Ready?")
		await get_tree().create_timer(1).timeout
		$"UI/GameplayText".hide()
		gameplay_loaded = true
	
	if gameplay_loaded:
		$UI/ScoreText.text = str(Global.score)
		$UI/LivesText.text = str("*", Global.player.lives)

		# Handle Pausing
		if Input.is_action_just_pressed("Pause") and is_paused == false:
			$"UI/GameplayText".text = str("Paused")
			$"UI/GameplayText".show()
			Engine.time_scale = 0
			is_paused = true
		elif Input.is_action_just_pressed("Pause") and is_paused == true:
			$"UI/GameplayText".hide()
			Engine.time_scale = 1
			is_paused = false

		if Global.player.is_dead:
			$"UI/GameplayText".text = str("Game Over")
			$"UI/GameplayText".show()
			Global.high_score = Global.score
			await get_tree().create_timer(5).timeout
			Global.splash_done = true
			get_tree().reload_current_scene()
	
	#print(Global.score)

func clear_screen() -> void:
	if gameplay_loaded:
		for node in $SubViewport/Gameplay/EnemySpawner/Enemies.get_children():
			node.queue_free()
