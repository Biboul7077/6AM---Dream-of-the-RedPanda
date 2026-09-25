extends ColorRect

@export var duration: float = 0.6
@export var max_radius: float = 1.3

func _ready() -> void:
	var vp_size := get_viewport_rect().size
	material.set_shader_parameter("aspect", vp_size.x / vp_size.y)

	var player := get_tree().get_first_node_in_group("player")
	if player:
		var cam := get_viewport().get_camera_2d()
		var screen_pos: Vector2 = cam.unproject_position(player.global_position) if cam else player.global_position
		material.set_shader_parameter("center", screen_pos / vp_size)

	var tween := create_tween()
	tween.tween_method(_set_radius, 0.0, max_radius, duration)
	tween.tween_callback(queue_free)

func _set_radius(r: float) -> void:
	material.set_shader_parameter("radius", r)
