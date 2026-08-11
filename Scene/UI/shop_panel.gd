extends PanelContainer

@onready var upgrade_1: Button = $MarginContainer/HBoxContainer/Upgrade1
@onready var upgrade_2: Button = $MarginContainer/HBoxContainer/Upgrade2
@onready var upgrade_3: Button = $MarginContainer/HBoxContainer/Upgrade3
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var shop_set: Array[Upgrade] = [null,null,null]

var color_array: Array[Color] = [
	Color(255, 180, 50, 1),
	Color("599d7fff"),
	Color("6088adff"),
	Color("8b72b7ff"),
	Color("ce7f24ff")
	]
var money := 0

func _process(delta: float) -> void:
	shop_set = UpgradeManager.current_shop
	if shop_set[0] != null:
		upgrade_1.get_node("MarginContainer/VBoxContainer/MarginContainer/LabelEffect").text = shop_set[0].upgrade_name
		upgrade_1.get_node("MarginContainer/VBoxContainer/MarginContainer/LabelEffect").add_theme_color_override("font_color",color_array[shop_set[0].rarity])
		upgrade_1.get_node("MarginContainer/VBoxContainer/TextureRect").texture = shop_set[0].icon
		upgrade_1.get_node("MarginContainer/VBoxContainer/LabelPrice").text = shop_set[0].description
	if shop_set[1] != null:
		upgrade_2.get_node("MarginContainer/VBoxContainer/MarginContainer/LabelEffect").text = shop_set[1].upgrade_name
		upgrade_2.get_node("MarginContainer/VBoxContainer/MarginContainer/LabelEffect").add_theme_color_override("font_color",color_array[shop_set[1].rarity])
		upgrade_2.get_node("MarginContainer/VBoxContainer/TextureRect").texture = shop_set[1].icon
		upgrade_2.get_node("MarginContainer/VBoxContainer/LabelPrice").text = shop_set[1].description
	if shop_set[2] != null:
		upgrade_3.get_node("MarginContainer/VBoxContainer/MarginContainer/LabelEffect").text = shop_set[2].upgrade_name
		upgrade_3.get_node("MarginContainer/VBoxContainer/MarginContainer/LabelEffect").add_theme_color_override("font_color",color_array[shop_set[2].rarity])
		upgrade_3.get_node("MarginContainer/VBoxContainer/TextureRect").texture = shop_set[2].icon
		upgrade_3.get_node("MarginContainer/VBoxContainer/LabelPrice").text = shop_set[2].description


func _on_upgrade_1_pressed() -> void:
	if InventoryManager.inventory.get("KeoCoin") != null:
		money = InventoryManager.inventory["KeoCoin"]
		var upgrade = shop_set[0]
		if money >= 40:
			var current_value = GameManager.get(upgrade.variable_name)
			var new_value = apply_operation(current_value, upgrade.operation, upgrade.value)
			GameManager.set(upgrade.variable_name, new_value)
			InventoryManager.add_collectable("KeoCoin", - 40)
			audio_stream_player.play()


func _on_upgrade_2_pressed() -> void:
	if InventoryManager.inventory.get("KeoCoin") != null:
		money = InventoryManager.inventory["KeoCoin"]
		var upgrade = shop_set[1]
		if money >= 40:
			var current_value = GameManager.get(upgrade.variable_name)
			var new_value = apply_operation(current_value, upgrade.operation, upgrade.value)
			GameManager.set(upgrade.variable_name, new_value)
			InventoryManager.add_collectable("KeoCoin", - 40)
			audio_stream_player.play()


func _on_upgrade_3_pressed() -> void:
	if InventoryManager.inventory.get("KeoCoin") != null:
		money = InventoryManager.inventory["KeoCoin"]
		var upgrade = shop_set[2]
		if money >= 40:
			var current_value = GameManager.get(upgrade.variable_name)
			var new_value = apply_operation(current_value, upgrade.operation, upgrade.value)
			GameManager.set(upgrade.variable_name, new_value)
			InventoryManager.add_collectable("KeoCoin", - 40)
			audio_stream_player.play()


func apply_operation(current, op: DataTypes.Operator, value):
	match op:
		0:
			return current + value
		1:
			return current - value
		2:
			return current * value
		3:
			return current / value
		4:
			return value
		_:
			push_error("Unknown operation: %s" % op)
			return current
