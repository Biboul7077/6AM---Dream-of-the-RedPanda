class_name Nightmare
extends CharacterBody2D

@export var money_drops = [3,2,0]
@export var target: Player

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var particles_damage: GPUParticles2D = $ParticlesDamage
@onready var state_machine: NodeStateMachine = $StateMachine
@onready var frozen_nodes: Array[Node] = [
	$StateMachine,
	$ContactHitComponent,
	$ClawsHitComponent,
]

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
	TimeManager.timestop_changed.connect(on_timestop_changed)
	damage_component.max_damaged_reached.connect(on_max_damaged_reached)
	on_timestop_changed(TimeManager.timestop)


func _process(_delta: float) -> void:
	flash_amount = max(flash_amount - 0.03, 0.0)
	sprite_2d.material.set_shader_parameter('flash_amount',flash_amount)


func set_target(new_target: Player) -> void:
	if target == new_target:
		return
	var had_target := target != null
	target = new_target
	if new_target != null and not had_target:
		GameManager.mark_player_detected()
	elif new_target == null and had_target:
		GameManager.clear_player_detection()


func on_hurt(hit_damage: int) -> void:
	state_machine.current_node_state.transition.emit("KnockedOut")
	particles_damage.rotation = target.get_angle_to(global_position)
	particles_damage.emitting = true
	flash_amount = 1.0
	damage_component.apply_damage(hit_damage)
	await get_tree().create_timer(2.0).timeout


func on_max_damaged_reached() -> void:
	set_target(null)
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


func on_timestop_changed(stopped: bool) -> void:
	var mode := Node.PROCESS_MODE_DISABLED if stopped else Node.PROCESS_MODE_INHERIT
	for node in frozen_nodes:
		node.process_mode = mode
