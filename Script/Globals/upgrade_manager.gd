extends Node

const DAMAGE_UPGRADE_RESOURCE = preload("uid://dyk7d8a7gufym")
const RECOVERING_UPGRADE_RESOURCE = preload("uid://bxfhy7u77ju2k")
const SPEED_UPGRADE_RESOURCE = preload("uid://t4heijryrf3u")
const KILLER_QUEEN_DAMAGE_UPGRADE_RESOURCE = preload("uid://d2gglnsdcn4kv")
const TIME_STOP_DURATION_UPGRADE = preload("uid://cg3cj3xx14285")

var upgrades_data: Array[Upgrade] = [
	DAMAGE_UPGRADE_RESOURCE,
	RECOVERING_UPGRADE_RESOURCE,
	SPEED_UPGRADE_RESOURCE,
	KILLER_QUEEN_DAMAGE_UPGRADE_RESOURCE,
	TIME_STOP_DURATION_UPGRADE
]

@export var current_shop: Array[Upgrade] = [DAMAGE_UPGRADE_RESOURCE,RECOVERING_UPGRADE_RESOURCE,SPEED_UPGRADE_RESOURCE]

func choose_random_upgrade() -> Array[Upgrade]:
	upgrades_data.shuffle()
	return [upgrades_data[0],upgrades_data[1],upgrades_data[2]]
