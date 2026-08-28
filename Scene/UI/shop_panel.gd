extends PanelContainer

@onready var upgrade_1: Button = $MarginContainer/HBoxContainer/Upgrade1
@onready var upgrade_2: Button = $MarginContainer/HBoxContainer/Upgrade2
@onready var upgrade_3: Button = $MarginContainer/HBoxContainer/Upgrade3
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var shop_set: Array[ShopItem] = [null, null, null]

var color_array: Array[Color] = [
	Color(255, 180, 50, 1),
	Color("599d7fff"),
	Color("6088adff"),
	Color("8b72b7ff"),
	Color("ce7f24ff")
	]

func _process(delta: float) -> void:
	shop_set = UpgradeManager.current_shop
	_update_slot(upgrade_1, shop_set[0])
	_update_slot(upgrade_2, shop_set[1])
	_update_slot(upgrade_3, shop_set[2])


func _update_slot(button: Button, item: ShopItem) -> void:
	if item == null:
		return
	button.get_node("MarginContainer/VBoxContainer/MarginContainer/LabelEffect").text = item.item_name
	button.get_node("MarginContainer/VBoxContainer/MarginContainer/LabelEffect").add_theme_color_override("font_color", color_array[item.rarity])
	button.get_node("MarginContainer/VBoxContainer/TextureRect").texture = item.icon
	button.get_node("MarginContainer/VBoxContainer/LabelPrice").text = item.description
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


func _on_upgrade_1_pressed() -> void:
	_try_purchase(shop_set[0])


func _on_upgrade_2_pressed() -> void:
	_try_purchase(shop_set[1])


func _on_upgrade_3_pressed() -> void:
	_try_purchase(shop_set[2])
