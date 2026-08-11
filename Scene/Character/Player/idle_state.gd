extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var hurt_component: HurtComponent

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	GameInputEvents.movement_input()
	GameInputEvents.skill_input()
	
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")
	
	if GameInputEvents.dodge():
		transition.emit("Dodge")
	
	if GameInputEvents.skill_input() != -1:
		transition.emit("Cast")
	
	if GameInputEvents.attack():
		transition.emit("Attack")
	
	if GameManager.is_shop_opened:
		transition.emit("Locked")


func _on_enter() -> void:
	animated_sprite_2d.play("Idle")


func _on_exit() -> void:
	animated_sprite_2d.stop()


func on_hurt(hit_damage: int) -> void:
	transition.emit("KnockedOut")
