extends Area2D

@export var collectable_name: String
@export var collectable_audio: AudioStreamPlayer2D
@export var sprite_2d: Sprite2D

var value: int = 0

func _ready() -> void:
	call_deferred("initialize_amount")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var coin: Node = get_parent()
		collectable_audio.reparent(get_parent().get_parent())
		collectable_audio.play()
		collectable_audio.finished.connect(collectable_audio.queue_free)
		
		InventoryManager.add_collectable(collectable_name,value)
		coin.queue_free()

func initialize_amount() -> void:
	value = sprite_2d.value
