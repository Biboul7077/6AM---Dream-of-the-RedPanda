extends NodeState

@export var nightmare: Nightmare
@export var sprite_2d: Sprite2D
@export var healthbar_component: NightmareHealthbar
@export var attack_range: float = 40.0
@export var giveup_range: float = 420.0

var attack_timer: float = 0.0
var chase_speed: float
var distance: float

func _ready() -> void:
	healthbar_component.visible = false

func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	chase_speed = GameManager.enemy_stats.speed
	var target = nightmare.target
	if target == null:
		return

	var direction = (target.global_position - nightmare.global_position).normalized()
	distance = nightmare.global_position.distance_to(target.global_position)

	if distance > giveup_range:
		nightmare.set_target(null)
		return

	nightmare.velocity = direction * chase_speed
	nightmare.move_and_slide()
	if direction.x != 0:
		sprite_2d.flip_h = direction.x < 0

func _on_next_transitions() -> void:
	if nightmare.target == null:
		transition.emit("Idle")
	
	if distance <= attack_range:
		transition.emit("Attack")

func _on_enter() -> void:
	healthbar_component.visible = true
	attack_timer = 0.0

func _on_exit() -> void:
	nightmare.velocity = Vector2.ZERO
