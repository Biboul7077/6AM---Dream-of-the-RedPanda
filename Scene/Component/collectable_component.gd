extends Area2D

@export var collectable_name: String
@export var sprite_2d: Sprite2D

var value: int = 0

func _ready() -> void:
	call_deferred("initialize_amount")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		InventoryManager.add_collectable(collectable_name,value)
		get_parent().queue_free()

func initialize_amount() -> void:
	value = sprite_2d.value
