class_name ShopKeeper
extends Node2D

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var sprite_ui: Sprite2D = $SpriteUI

@export var shop_set: Array[ShopItem] = [null, null, null]
@export var is_first_shop: bool
@export var is_used: bool

var active: bool = false

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	shop_set = UpgradeManager.choose_random_upgrade(is_first_shop)
	for i in shop_set.size():
		if shop_set[i] != null:
			shop_set[i] = shop_set[i].duplicate()
	if is_first_shop:
		make_spell_free()


func _process(_delta: float) -> void:
	if active and Input.is_action_just_pressed("keyInteract") and !is_used:
		GameManager.is_shop_opened = true
		UpgradeManager.current_shop = shop_set
		UpgradeManager.shop_id = self
		TimeManager.pause(&"shop")
	if active and Input.is_action_just_pressed("keyExit"):
		print("bouh")
		GameManager.is_shop_opened = false
		TimeManager.resume(&"shop")


func close_shop() -> void:
	if not GameManager.is_shop_opened:
		return
	GameManager.is_shop_opened = false
	TimeManager.resume(&"shop")


func make_spell_free():
	for item in shop_set:
		item.price = 0


func on_interactable_activated() -> void:
	active = true
	sprite_ui.visible = true


func on_interactable_deactivated() -> void:
	active = false
	sprite_ui.visible = false
