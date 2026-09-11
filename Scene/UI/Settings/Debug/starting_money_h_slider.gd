extends HSlider

func _on_value_changed(_value: float) -> void:
	GameManager.player_start_money = _value
