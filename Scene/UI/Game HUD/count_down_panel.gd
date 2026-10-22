extends PanelContainer

@onready var time_label: Label = $MarginContainer/TimeLabel

func _ready() -> void:
	TimeManager.time_tick.connect(on_time_tick)

func on_time_tick(hour: int, minute: int) -> void:
	time_label.text = "%01d:%02d" % [hour, minute]
