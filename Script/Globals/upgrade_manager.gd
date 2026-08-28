extends Node

# UPGRADE
const DAMAGE_UPGRADE_RESOURCE = preload("uid://dyk7d8a7gufym")
const RECOVERING_UPGRADE_RESOURCE = preload("uid://bxfhy7u77ju2k")
const SPEED_UPGRADE_RESOURCE = preload("uid://t4heijryrf3u")
const KILLER_QUEEN_DAMAGE_UPGRADE_RESOURCE = preload("uid://d2gglnsdcn4kv")
const TIME_STOP_DURATION_UPGRADE = preload("uid://cg3cj3xx14285")

# UNLOCK
const UNLOCK_ZAWARUDO_DATA = preload("uid://bnsugu8ta0y81")


var upgrades_data: Array[Upgrade] = [
	DAMAGE_UPGRADE_RESOURCE,
	RECOVERING_UPGRADE_RESOURCE,
	SPEED_UPGRADE_RESOURCE,
	KILLER_QUEEN_DAMAGE_UPGRADE_RESOURCE,
	TIME_STOP_DURATION_UPGRADE
]

var skill_unlocks_data: Array[SkillUnlock] = [
	UNLOCK_ZAWARUDO_DATA
]

@export var current_shop: Array[ShopItem] = [DAMAGE_UPGRADE_RESOURCE, RECOVERING_UPGRADE_RESOURCE, SPEED_UPGRADE_RESOURCE]

## Poids relatif de tirage d'un sort par rapport à un upgrade de stat.
## 1.0 = même chance qu'un upgrade classique. Baisse-le si tu veux les sorts plus rares.
@export var skill_unlock_weight: float = 1.0


func choose_random_upgrade() -> Array[ShopItem]:
	var pool: Array[ShopItem] = []
	pool.append_array(upgrades_data)

	for unlock in skill_unlocks_data:
		if unlock.can_be_purchased():
			# ajoute plusieurs fois l'entrée pour pondérer sa chance d'apparition
			for i in range(max(1, roundi(skill_unlock_weight))):
				pool.append(unlock)

	pool.shuffle()

	var result: Array[ShopItem] = []
	var seen: Array[ShopItem] = []
	for item in pool:
		if result.size() >= 3:
			break
		if item in seen:
			continue
		seen.append(item)
		result.append(item)

	while result.size() < 3:
		result.append(null)

	return result
