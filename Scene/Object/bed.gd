extends Node2D
@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var sprite_ui: Sprite2D = $SpriteUI

var active: bool = false

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if active:
		if Input.is_action_just_pressed("keyInteract"):
			GameManager.show_game_menu_screen(true)
			TimeManager.set_initial_time()

func on_interactable_activated() -> void:
	active = true
	sprite_ui.visible = true

func on_interactable_deactivated() -> void:
	active = false
	sprite_ui.visible = false
