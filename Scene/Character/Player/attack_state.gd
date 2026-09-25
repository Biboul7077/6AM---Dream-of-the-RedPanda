extends NodeState


@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D

@export_group("Attack Constants")
@export var attack_speed: float = 0.2
@export var sword_return_speed: float = 0.5

@onready var sword: Sprite2D = $"../../AnimatedSprite2D/SwordPivot/Sword"
@onready var animation_player: AnimationPlayer = $"../../AnimatedSprite2D/SwordPivot/Sword/AnimationPlayer"
@onready var combo_timer: Timer = $"../../AnimatedSprite2D/SwordPivot/Sword/Timer"


var attack_combo: int = 0
var attack_combo_max: int = 3


func _ready() -> void:
	hit_component_collision_shape.disabled = true
	animation_player.animation_finished.connect(on_animation_finished)
	combo_timer.timeout.connect(on_combo_timer_timeout)


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if player.can_slash and GameInputEvents.attack() and attack_combo < attack_combo_max:
		swing(attack_combo + 1)


func _on_enter() -> void:
	player.is_attacking = true
	attack_combo = 0
	swing(1)


func _on_exit() -> void:
	hit_component_collision_shape.disabled = true
	combo_timer.stop()
	player.is_attacking = false
	player.can_slash = true


func swing(combo_index: int) -> void:
	attack_combo = combo_index
	player.can_slash = false
	
	var mouse_pos = player.get_global_mouse_position()
	player.sword_pivot.global_rotation = player.global_position.direction_to(mouse_pos).angle()
	
	if combo_timer.wait_time > 0:
		combo_timer.start()
	
	hit_component_collision_shape.disabled = false
	var anim_name := "slash_" + str(combo_index)
	animation_player.speed_scale = animation_player.get_animation(anim_name).length/attack_speed
	animation_player.play(anim_name)


func on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slash_"+str(attack_combo):
		if attack_combo_max > attack_combo:
			player.can_slash = true
	elif anim_name == "return":
		transition.emit("Idle")


func on_combo_timer_timeout() -> void:
	player.can_slash = false
	animation_player.speed_scale = animation_player.get_animation("return").length / sword_return_speed
	animation_player.play("return")
	hit_component_collision_shape.disabled = true
	combo_timer.stop()
