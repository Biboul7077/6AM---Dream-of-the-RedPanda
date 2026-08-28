class_name Nightmare
extends CharacterBody2D

@export var money_drops = [3,2,0]
@export var target: Player

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
var keocoin_scene = preload("uid://bnq0hq4fcsv3k")

signal player_detected
signal nightmare_vanished

func _ready() -> void:
	add_to_group("enemies")
	hurt_component.hurt.connect(on_hurt)
	GameManager.difficulty_increased.connect(on_difficulty_increased)
	damage_component.max_damaged_reached.connect(on_max_damaged_reached)

func on_hurt(hit_damage: int) -> void:
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

func on_difficulty_increased() -> void:
	damage_component.current_damage = (damage_component.current_damage * GameManager.enemy_maximum_damage)/damage_component.max_damage
	damage_component.max_damage = GameManager.enemy_maximum_damage
