extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed : float = 120.0
@export var hurt_component: HurtComponent

var direction : Vector2


func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	speed = GameManager.player_stats.speed * GameManager.player_stats.speed_boost
	direction = GameInputEvents.movement_input()
	
	if direction != Vector2.ZERO:
		player.player_input_direction = direction
		player.player_facing_direction = GameInputEvents.snap_to_cardinal(direction)
	
	player.velocity = direction * speed
	player.move_and_slide()


func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")
	
	if GameInputEvents.dodge():
		transition.emit("Dodge")


func _on_enter() -> void:
	animated_sprite_2d.play("Walk")


func _on_exit() -> void:
	pass

func on_hurt(_hit_damage: int) -> void:
	transition.emit("KnockedOut")
