class_name ShopItem
extends Resource

@export_group("Metadata")
@export var item_name: String
@export var description: String
@export var icon: Texture2D
@export var rarity: DataTypes.Rarity
@export var price: int = 0

func apply(_target: Node = null) -> void:
	push_warning("ShopItem.apply() non implémenté pour: %s" % item_name)

func can_be_purchased(_target: Node = null) -> bool:
	return true
