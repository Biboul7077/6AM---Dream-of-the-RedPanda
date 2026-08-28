extends Button

@export var audio_stream_player_2d: AudioStreamPlayer2D

func _on_pressed() -> void:
	audio_stream_player_2d.play()
