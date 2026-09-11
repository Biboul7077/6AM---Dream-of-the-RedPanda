extends HSlider

@export var audio_bus_name: String = ""

var audio_bus_id


func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)


func _on_value_changed(_value: float) -> void:
	AudioServer.set_bus_volume_linear(audio_bus_id, _value)
