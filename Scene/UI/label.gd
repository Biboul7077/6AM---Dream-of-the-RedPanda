extends Label

var money: int = 0

func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)

func on_inventory_changed():
	if InventoryManager.inventory.get("KeoCoin") != null:
		money = InventoryManager.inventory["KeoCoin"]
	text = str(money)+" KeoCoins"
