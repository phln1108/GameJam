extends Node

@export var musics: Array[AudioStream]
var selected = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if len(musics) > 0:
		$AudioStreamPlayer.stream = musics[selected]
		$AudioStreamPlayer.play()

func _on_audio_stream_player_finished() -> void:
	selected += 1
	if selected == len(musics):
		selected = 0
	$AudioStreamPlayer.stream = musics[selected]
	$AudioStreamPlayer.play()
