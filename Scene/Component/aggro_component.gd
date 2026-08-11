class_name AggroComponent
extends Area2D

signal player_detected(target: Player)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_detected.emit(body)
