class_name MadeInHeavenSkill
extends Skill
 
func executer(caster: Node, cible = null) -> void:
	GameManager.player_speed_boost *= 1.5
	await caster.get_tree().create_timer(2.0).timeout
	GameManager.player_speed_boost *= 1.5
	await caster.get_tree().create_timer(2.0).timeout
	GameManager.player_speed_boost *= 1.5
	await caster.get_tree().create_timer(2.0).timeout
	GameManager.player_speed_boost *= 1.5
	await caster.get_tree().create_timer(2.0).timeout
	GameManager.player_speed_boost = 1.0
