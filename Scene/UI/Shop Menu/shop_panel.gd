class_name ShopPanel
extends PanelContainer

@onready var upgrade_1: UpgradeButton = $MarginContainer/HBoxContainer/UpgradeButton1
@onready var upgrade_2: UpgradeButton = $MarginContainer/HBoxContainer/UpgradeButton2
@onready var upgrade_3: UpgradeButton = $MarginContainer/HBoxContainer/UpgradeButton3
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var shop_set: Array[ShopItem] = [null, null, null]
@export var shop_id: ShopKeeper

var game_screen_scene_root:String = "/root/MainScene/GameRoot/GameScreen"

var color_array: Array[Color] = [
	Color("ffffffff"),
	Color("599d7fff"),
	Color("6088adff"),
	Color("8b72b7ff"),
	Color("ce7f24ff")
	]

func _process(_delta: float) -> void:
	shop_set = UpgradeManager.current_shop
	shop_id = UpgradeManager.shop_id
	_update_slot(upgrade_1, shop_set[0])
	_update_slot(upgrade_2, shop_set[1])
	_update_slot(upgrade_3, shop_set[2])


func _update_slot(button: UpgradeButton, item: ShopItem) -> void:
	if item == null:
		return
	button.upgrade_name = item.item_name
	button.upgrade_rarity = color_array[item.rarity]
	button.upgrade_icon = item.icon
	button.upgrade_price = item.price
	button.upgrade_description = item.description
	button.disabled = not item.can_be_purchased()


func _try_purchase(item: ShopItem) -> void:
	if item == null:
		return
	if not item.can_be_purchased():
		return
	if InventoryManager.inventory.get("KeoCoin") == null:
		return

	var money: int = InventoryManager.inventory["KeoCoin"]
	if money < item.price:
		return

	item.apply()
	InventoryManager.add_collectable("KeoCoin", -item.price)
	audio_stream_player.play()
	shop_id.is_used = true
	shop_id.close_shop()


func _on_upgrade_button_1_pressed() -> void:
	_try_purchase(shop_set[0])


func _on_upgrade_button_2_pressed() -> void:
	_try_purchase(shop_set[1])


func _on_upgrade_button_3_pressed() -> void:
	_try_purchase(shop_set[2])
