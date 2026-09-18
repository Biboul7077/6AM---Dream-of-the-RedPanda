extends NodeState

@export var aggro_component: AggroComponent
@export var nightmare: Node
@export var sprite_2d: Sprite2D

func _ready() -> void:
	aggro_component.player_detected.connect(on_player_detected)


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	pass


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	pass


func on_player_detected(target: Player) -> void:
	nightmare.target = target
