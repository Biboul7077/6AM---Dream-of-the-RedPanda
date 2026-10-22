extends CanvasLayer


func _ready() -> void:
	visible = GameManager.is_shop_opened
	GameManager.shop_state_changed.connect(on_shop_state_changed)


func on_shop_state_changed(opened: bool) -> void:
	visible = opened
