extends ProgressBar

func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)


func on_inventory_changed(key):
	if key == "ChrononShard":
		value = InventoryManager.inventory["ChrononShard"]
