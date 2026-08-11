extends NodeState


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if GameManager.is_shop_opened == false:
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	pass
