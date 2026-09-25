class_name Upgrade
extends ShopItem

@export_group("Upgrade")
@export var variable_name: String
@export var value: float
@export var operation: DataTypes.Operator

func apply(_target: Node = null) -> void:
	var stats := GameManager.player_stats
	if !variable_name in stats:
		push_error("Upgrade '%s' targets non-existing variable : %s" % [item_name, variable_name])
		return
	
	match operation:
		DataTypes.Operator.ADD:
			GameManager.set(variable_name, stats.get(variable_name) + value)
		DataTypes.Operator.MUL:
			GameManager.set(variable_name, stats.get(variable_name) * value)
		DataTypes.Operator.SET:
			GameManager.set(variable_name, value)
