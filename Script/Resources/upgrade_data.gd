class_name Upgrade
extends Resource


## --- Metadata ---
@export_group("Metadata")
@export var upgrade_name: String
@export var description: String
@export var icon: Texture2D
@export var rarity: DataTypes.Rarity

## --- Effects ---
@export_group("Upgrade")
@export var variable_name: String
@export var value: float
@export var operation: DataTypes.Operator
