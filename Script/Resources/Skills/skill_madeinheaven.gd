class_name MadeInHeavenSkill
extends Skill
 
func executer(_caster: Node, _target = null) -> void:
	GameManager.player_stats.speed_boost *= 1.5
	await _caster.get_tree().create_timer(2.0).timeout
	GameManager.player_stats.speed_boost *= 1.5
	await _caster.get_tree().create_timer(2.0).timeout
	GameManager.player_stats.speed_boost *= 1.5
	await _caster.get_tree().create_timer(2.0).timeout
	GameManager.player_stats.speed_boost *= 1.5
	await _caster.get_tree().create_timer(2.0).timeout
	GameManager.player_stats.speed_boost = 1.0
