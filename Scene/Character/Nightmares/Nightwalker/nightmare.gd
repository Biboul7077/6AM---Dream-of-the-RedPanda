class_name Nightmare
extends CharacterBody2D

@export var money_drops = [3,2,0]
@export var target: Player

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var particles_damage: GPUParticles2D = $ParticlesDamage
var keocoin_scene = preload("uid://bnq0hq4fcsv3k")
var chrononshard_scene = preload("uid://b15xvras5iasp")
var flash_amount: float = 0.0

@warning_ignore("unused_signal")
signal player_detected
signal nightmare_vanished

func _ready() -> void:
	add_to_group("enemies")
	particles_damage.emitting = false
	hurt_component.hurt.connect(on_hurt)
	GameManager.difficulty_increased.connect(on_difficulty_increased)
	TimeManager.timestop_changed.connect(on_timestop_change)
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
	nightmare_vanished.emit()
	call_deferred("add_resources_scene")
	queue_free()

func add_resources_scene() -> void:
	for coin_amount in money_drops:
		for coin in range(coin_amount):
			var keocoin_instance = keocoin_scene.instantiate() as Node2D
			keocoin_instance.position = position + Vector2(randi_range(-20,20),randi_range(-20,20))
			keocoin_instance.coin_type = money_drops.find(coin_amount)
			get_parent().add_child(keocoin_instance)
	var chrononshard_instance = chrononshard_scene.instantiate() as Node2D
	chrononshard_instance.position = position
	get_parent().add_child(chrononshard_instance)

func on_difficulty_increased() -> void:
	damage_component.current_damage = (damage_component.current_damage * GameManager.enemy_maximum_damage)/damage_component.max_damage
	damage_component.max_damage = GameManager.enemy_maximum_damage

func on_timestop_change(stopped: bool) -> void:
	process_mode = Node.PROCESS_MODE_DISABLED if stopped else PROCESS_MODE_INHERIT
