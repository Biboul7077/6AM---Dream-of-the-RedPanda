extends Sprite2D

@export var coin_type: DataTypes.CoinValue = DataTypes.CoinValue.Copper
var value: int = 0

func _ready() -> void:
	frame = int(coin_type)
	match coin_type:
		0:
			value = 1
		1:
			value = 5
		2:
			value = 20
