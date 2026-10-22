extends ColorRect

@export_range(0.0,1.0) var shockwave_progress: float

var player: Node2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	material.set_shader_parameter('progress',0)
	VFXManager.timestop_started.connect(on_timestop_started)
	VFXManager.timestop_ended.connect(on_timestop_ended)


func _process(delta: float) -> void:
	material.set_shader_parameter('progress',shockwave_progress)

func on_timestop_started() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "shockwave_progress", 1.0, 1.0)

func on_timestop_ended() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "shockwave_progress", 0.0, 1.0)
