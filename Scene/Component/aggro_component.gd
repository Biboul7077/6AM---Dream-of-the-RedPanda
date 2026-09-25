class_name AggroComponent
extends Area2D

signal player_detected(target: Player)

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	monitoring = false
	await get_tree().physics_frame
	await get_tree().physics_frame
	monitoring = true


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_detected.emit(body)
