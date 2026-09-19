class_name NightmareHealthbar
extends ProgressBar

@export var damage_component: DamageComponent

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	call_deferred("set_variable")

func _process(_delta: float) -> void:
	value = max_value - damage_component.current_damage
	max_value = damage_component.max_damage

func set_variable():
	max_value = damage_component.max_damage
	value = damage_component.current_damage
