extends Node

var inventory: Dictionary = Dictionary()

signal inventory_changed

func add_collectable(collectable_name: String, value = 1) -> void:
	inventory.get_or_add(collectable_name)

	if inventory[collectable_name] == null:
		inventory[collectable_name] = value
	else:
		inventory[collectable_name] += value
	
	inventory_changed.emit()

func reset_collectable() -> void:
	inventory.clear()
