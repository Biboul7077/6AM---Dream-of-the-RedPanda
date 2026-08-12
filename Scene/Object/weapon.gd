extends Node2D
class_name Weapon

signal attack_started
signal attack_finished

@export var swing_angle_deg: float = 30.0
@export var swing_duration: float = 0.25
@export var follow_target: bool = true
@export var swing_pivot: Node2D
@export var hit_component_collision_shape_2d: CollisionShape2D

var wielder: Node2D
var is_player_owned: bool = false
var is_attacking: bool = false

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var hit_component: HitComponent = $SwingPivot/HitComponent

func setup(new_wielder: Node2D, player_owned: bool) -> void:
	wielder = new_wielder
	is_player_owned = player_owned
	hit_component_collision_shape_2d.disabled = true

func _process(_delta: float) -> void:
	if follow_target and not is_attacking:
		rotation = _get_target_angle()
	

func _get_target_angle() -> float:
	if is_player_owned:
		var mouse_pos = get_global_mouse_position()
		return (mouse_pos - global_position).angle()
	else:
		if wielder and wielder.has_method("get_current_target"):
			var target = wielder.get_current_target()
			if target:
				return (target.global_position - global_position).angle()
		return rotation

func attack() -> void:
	if is_attacking:
		return
	is_attacking = true
	hit_component.hit_damage = StatisticsManager.player_damage
	attack_started.emit()
	
	rotation = _get_target_angle()
	swing_pivot.rotation = deg_to_rad(-swing_angle_deg)
	hit_component_collision_shape_2d.disabled = false
	
	var tween := create_tween()
	tween.tween_property(swing_pivot, "rotation", deg_to_rad(swing_angle_deg), swing_duration)
	tween.finished.connect(_on_attack_finished)

func _on_attack_finished() -> void:
	is_attacking = false
	swing_pivot.rotation = 0.0
	hit_component_collision_shape_2d.disabled = true
	attack_finished.emit()


func _on_hit_component_body_entered(body: Node2D) -> void:
	if body is Nightmare:
		audio_stream_player_2d.play()
