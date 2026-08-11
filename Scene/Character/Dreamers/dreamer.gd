extends StaticBody2D

const DREAMER_LYS = preload("uid://t7atgl0tp1na")
const DREAMER_THIBOUL = preload("uid://8h87677a8qje")
const DREAMER_WILLOW = preload("uid://plky6wvo4t73")
const NIGHTMARE_SCENE = preload("uid://usyq26lqno3i")

@export var nightmare_initial_amount: int = 2
@export var range_max: int = 100

@onready var nightmare_current_amount: int = nightmare_initial_amount
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var particles_sleep: GPUParticles2D = $ParticlesSleep
@onready var particles_fear: GPUParticles2D = $ParticlesFear

func _ready() -> void:
	particles_sleep.emitting = false
	sprite_2d.texture = [DREAMER_LYS,DREAMER_WILLOW,DREAMER_THIBOUL].pick_random()
	for i in range(nightmare_initial_amount):
		var nightmare_spawn = NIGHTMARE_SCENE.instantiate()
		var angle = (2*PI) / (i + 1)
		nightmare_spawn.position = to_cartesian(range_max,angle)
		nightmare_spawn.nightmare_vanished.connect(on_nightmare_vanished)
		add_child(nightmare_spawn)

func to_cartesian(r, angle) -> Vector2:
			var x = r * cos(angle)
			var y = r * sin(angle)
			return Vector2(x, y)

func _process(delta: float) -> void:
	if nightmare_current_amount <= 0:
		particles_fear.emitting = false
		particles_sleep.emitting = true

func on_nightmare_vanished():
	nightmare_current_amount -= 1
