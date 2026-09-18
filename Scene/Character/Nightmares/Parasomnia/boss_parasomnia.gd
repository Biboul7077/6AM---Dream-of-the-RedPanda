extends CharacterBody2D

@export var target: Player

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var particles_damage: GPUParticles2D = $ParticlesDamage
var flash_amount: float = 0.0

@warning_ignore("unused_signal")
signal player_detected

func _ready() -> void:
	add_to_group("enemies")
	particles_damage.emitting = false
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damaged_reached.connect(on_max_damaged_reached)

func _process(_delta: float) -> void:
	flash_amount = max(flash_amount - 0.03, 0.0)
	sprite_2d.material.set_shader_parameter('flash_amount',flash_amount)

func on_hurt(hit_damage: int) -> void:
	particles_damage.rotation = target.get_angle_to(global_position)
	particles_damage.emitting = true
	flash_amount = 1.0
	damage_component.apply_damage(hit_damage)
	await get_tree().create_timer(2.0).timeout

func on_max_damaged_reached() -> void:
	queue_free()
