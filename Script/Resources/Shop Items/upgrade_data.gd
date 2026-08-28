class_name Upgrade
extends ShopItem

@export_group("Upgrade")
@export var variable_name: String
@export var value: float
@export var operation: DataTypes.Operator

func apply(target: Node = null) -> void:
	match operation:
		DataTypes.Operator.ADD:
			GameManager.set(variable_name, GameManager.get(variable_name) + value)
		DataTypes.Operator.MUL:
			GameManager.set(variable_name, GameManager.get(variable_name) * value)
