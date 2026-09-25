class_name ZaWarudoSkill
extends Skill
 
func executer(_caster: Node, _target = null) -> void:
	VFXManager.timestop_started.emit()
	TimeManager.pause_for(&"zawarudo", GameManager.player_stats.time_stop_duration)
