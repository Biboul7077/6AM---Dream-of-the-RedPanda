extends AudioStreamPlayer

@export var fade_speed := 2.0  # dB par frame, à ajuster

const VOLUME_ZERO := -40.0

var target_detected := false

func _ready() -> void:
	stream.set_sync_stream_volume(1, VOLUME_ZERO)

func _process(_delta: float) -> void:
	if stream == null:
		return
	
	target_detected = GameManager.is_player_detected

	var vol_exploration = VOLUME_ZERO if target_detected else 1.0
	var vol_combat = 1.0 if target_detected else VOLUME_ZERO

	# Conversion linéaire -> dB avec un fondu progressif
	var current_0 = stream.get_sync_stream_volume(0)
	var current_1 = stream.get_sync_stream_volume(1)

	var goal_0 = vol_exploration
	var goal_1 = vol_combat

	stream.set_sync_stream_volume(0, move_toward(current_0, goal_0, fade_speed))
	stream.set_sync_stream_volume(1, move_toward(current_1, goal_1, fade_speed))
	
	stream_paused = (TimeManager.timestop and !GameManager.is_shop_opened)
