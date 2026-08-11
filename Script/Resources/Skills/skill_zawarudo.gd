class_name ZaWarudoSkill
extends Skill
 
func executer(caster: Node, cible = null) -> void:
	TimeManager.timestop = true
	#await caster.get_tree().create_timer(GameManager.player_time_stop_duration).timeout
	#TimeManager.timestop = false
