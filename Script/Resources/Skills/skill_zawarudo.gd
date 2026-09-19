class_name ZaWarudoSkill
extends Skill
 
func executer(_caster: Node, _target = null) -> void:
	TimeManager.pause_for(&"zawarudo", GameManager.player_time_stop_duration)
