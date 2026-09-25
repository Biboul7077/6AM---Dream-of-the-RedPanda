extends NodeState

@export var aggro_component: AggroComponent
@export var nightmare: Nightmare
@export var sprite_2d: Sprite2D

var player_spotted: bool

func _ready() -> void:
	aggro_component.player_detected.connect(on_player_detected)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if player_spotted:
		transition.emit("Chase")


func _on_enter() -> void:
	player_spotted = false


func _on_exit() -> void:
	pass

func on_player_detected(target: Player) -> void:
	nightmare.set_target(target)
	player_spotted = true
