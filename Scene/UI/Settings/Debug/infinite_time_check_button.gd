extends CheckButton


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		GameManager.game_speed = 0.0
	else:
		GameManager.game_speed = 5.0
