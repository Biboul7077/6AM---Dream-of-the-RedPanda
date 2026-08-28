extends NodeState

@export var hit_component_collision_shape: CollisionShape2D
@export var nightmare: Nightmare
@export var sprite_2d: Sprite2D

@export var attack_range: float = 40.0
@export var attack_damage: int = 10
@export var attack_cooldown: float = 6.5

var attack_timer: float = 0.0
var direction

func _ready() -> void:
	hit_component_collision_shape.disabled = true

func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(delta: float) -> void:
	attack_timer -= delta
	
	if attack_timer <= attack_cooldown/2:
		hit_component_collision_shape.disabled = true

func _on_next_transitions() -> void:
	if nightmare.target == null:
		transition.emit("Idle")
	
	if attack_timer <= 0.0:
		transition.emit("Chase")

func _on_enter() -> void:
	attack_timer = attack_cooldown
	nightmare.velocity = Vector2.ZERO
	hit_component_collision_shape.disabled = false
	direction = (nightmare.target.global_position - nightmare.global_position).angle()
	hit_component_collision_shape.rotation = direction

func _on_exit() -> void:
	pass
