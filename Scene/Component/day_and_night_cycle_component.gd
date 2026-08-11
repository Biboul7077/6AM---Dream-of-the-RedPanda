class_name DayNightCycleComponent
extends CanvasModulate

@export var initial_hour: int = 0:
	set(ih):
		TimeManager.set_initial_time()

@export var initial_minute: int = 0:
	set(im):
		TimeManager.set_initial_time()

@export var day_night_gradient_texture: GradientTexture1D

func _ready() -> void:
	add_to_group("day_night_modulate")
	
	TimeManager.initial_hour = initial_hour
	TimeManager.initial_minute = initial_minute
	TimeManager.set_initial_time()
	
	TimeManager.game_time.connect(on_game_time)

func on_game_time(time: float) -> void:
	var sample_value = 0.5 * (sin(time - PI * 0.5) + 1.0)
	color = day_night_gradient_texture.gradient.sample(sample_value)
