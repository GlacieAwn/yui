extends Node

const MAX_STREAM_COUNT = 16

var stream_pool

var music_player
var sfx_player


func _ready() -> void:
	Global.audio_manager = self
	stream_pool = [MAX_STREAM_COUNT]

	music_player = AudioStreamPlayer.new()
	music_player.name = "MusicPlayer"
	music_player.volume_db = -10.0
	add_child(music_player)

	sfx_player = AudioStreamPlayer.new()
	sfx_player.name = "SFXPlayer"
	add_child(sfx_player)
	
func _process(_delta: float) -> void:
	pass
		
		
func play_music(file: AudioStream) -> void:
	music_player.stream = file
	music_player.play()
	
func play_sfx(file: AudioStream) -> void:
	sfx_player.stream = file
	
	if sfx_player.playing:
		for i in MAX_STREAM_COUNT:
			var audio_player = AudioStreamPlayer2D.new()
			stream_pool.append(audio_player)
			add_child(stream_pool.get_items())
			audio_player.play()
	sfx_player.play()
	

func stop_music() -> void:
	music_player.stop()
