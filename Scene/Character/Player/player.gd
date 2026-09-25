class_name Player
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword_pivot: Node2D = $AnimatedSprite2D/SwordPivot
@onready var sword: Sprite2D = $AnimatedSprite2D/SwordPivot/Sword

@export_group("Attack Constants")
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

func _physics_process(_delta: float) -> void:
	if player_facing_direction == Vector2.LEFT:
		animated_sprite_2d.flip_h = true
	elif player_facing_direction == Vector2.RIGHT:
		animated_sprite_2d.flip_h = false

	if get_global_mouse_position().y > global_position.y:
		sword.show_behind_parent = true
	else:
		sword.show_behind_parent = false
