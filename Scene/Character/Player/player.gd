class_name Player
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword_pivot: Node2D = $AnimatedSprite2D/SwordPivot
@onready var sword: Sprite2D = $AnimatedSprite2D/SwordPivot/Sword
@onready var animation_player: AnimationPlayer = $AnimatedSprite2D/SwordPivot/Sword/AnimationPlayer
@onready var combo_timer: Timer = $AnimatedSprite2D/SwordPivot/Sword/Timer

@export_group("Attack Constants")
@export var attack_speed: float = 0.2
@export var sword_return_speed: float = 0.5
@export var sword_damage: float = 1.0
@export var sword_hit_component: CollisionShape2D

var player_input_direction: Vector2 = Vector2.ZERO
var player_facing_direction: Vector2 = Vector2.DOWN
var can_slash: bool = true
var is_attacking: bool = false
var attack_combo: int = 0
var attack_max_combo: int = 3

func _ready() -> void:
	add_to_group("player")
	sword_hit_component.disabled = true

func _physics_process(_delta: float) -> void:
	if player_facing_direction == Vector2.LEFT:
		animated_sprite_2d.flip_h = true
	elif player_facing_direction == Vector2.RIGHT:
		animated_sprite_2d.flip_h = false

	if get_global_mouse_position().y > global_position.y:
		sword.show_behind_parent = false
	else:
		sword.show_behind_parent = true
	
	if GameInputEvents.attack() and can_slash:
		if combo_timer.wait_time > 0:
			combo_timer.start()
		attack_combo += 1
		_start_attack()
	
	if not is_attacking:
		var mouse_pos = get_global_mouse_position()
		sword_pivot.global_rotation = global_position.direction_to(mouse_pos).angle()

func _start_attack() -> void:
	can_slash = false
	is_attacking = true
	var mouse_pos = get_global_mouse_position()
	sword_pivot.global_rotation = global_position.direction_to(mouse_pos).angle()
	
	sword_hit_component.disabled = false
	animation_player.speed_scale = animation_player.get_animation("slash_"+str(attack_combo)).length / attack_speed
	animation_player.play("slash_"+str(attack_combo))

func spawn_slash() -> void:
	pass

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slash_"+str(attack_combo):
		if attack_max_combo > attack_combo:
			can_slash = true
	else:
		attack_combo = 0
		is_attacking = false
		can_slash = true


func _on_timer_timeout() -> void:
	can_slash = false
	animation_player.speed_scale = animation_player.get_animation("return").length / sword_return_speed
	animation_player.play("return")
	sword_hit_component.disabled = true
	combo_timer.stop()
