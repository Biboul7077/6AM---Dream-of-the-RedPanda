class_name Player
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var player_input_direction : Vector2 = Vector2.ZERO
var player_facing_direction : Vector2 = Vector2.DOWN

func _physics_process(delta: float) -> void:
	if player_facing_direction == Vector2.LEFT:
		animated_sprite_2d.flip_h = true
	elif player_facing_direction == Vector2.RIGHT:
		animated_sprite_2d.flip_h = false
