class_name ZaWarudoSkill
extends Skill
 
func executer(_caster: Node, _target = null) -> void:
	TimeManager.timestop = true
	await _caster.get_tree().create_timer(GameManager.player_time_stop_duration).timeout
	TimeManager.timestop = false
