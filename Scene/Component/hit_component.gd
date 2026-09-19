class_name HitComponent
extends Area2D

@export var hit_damage : int = 1
@export var parent: Node


func _ready() -> void:
	if parent.is_in_group("enemies"):
		TimeManager.timestop_changed.connect(on_timestop_change)

func on_timestop_change(stopped: bool) -> void:
	process_mode = PROCESS_MODE_DISABLED if stopped else PROCESS_MODE_INHERIT
