extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D

@onready var weapon: Weapon = $"../../Marker2D/Weapon"

var direction : Vector2
var range_max : int = 20

func _ready() -> void:
	weapon.setup(player, true)
	weapon.attack_finished.connect(on_attack_finished)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	pass


func _on_enter() -> void:
	weapon.attack()


func _on_exit() -> void:
	animated_sprite_2d.stop()


func on_attack_finished() -> void:
	transition.emit("Idle")
