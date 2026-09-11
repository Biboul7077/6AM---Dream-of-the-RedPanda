extends Node2D
@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var sprite_ui: Sprite2D = $SpriteUI

@export var shop_set: Array[ShopItem] = [null, null, null]

var shop_screen_scene_root:String = "/root/MainScene/GameRoot/ShopScreen"
var game_screen_scene_root:String = "/root/MainScene/GameRoot/GameScreen"
var active: bool = false

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	shop_set = UpgradeManager.choose_random_upgrade()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if active and Input.is_action_just_pressed("keyInteract"):
		GameManager.is_shop_opened = true
		UpgradeManager.current_shop = shop_set
		TimeManager.timestop = true
		get_tree().root.get_node(shop_screen_scene_root).visible = true
		get_tree().root.get_node(game_screen_scene_root).visible = false
	if active and Input.is_action_just_pressed("keyExit"):
		GameManager.is_shop_opened = false
		TimeManager.timestop = false
		get_tree().root.get_node(shop_screen_scene_root).visible = false
		get_tree().root.get_node(game_screen_scene_root).visible = true

func on_interactable_activated() -> void:
	active = true
	sprite_ui.visible = true

func on_interactable_deactivated() -> void:
	active = false
	sprite_ui.visible = false
