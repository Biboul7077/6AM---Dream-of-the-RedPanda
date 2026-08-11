class_name KillerQueenSkill
extends Skill
 
func executer(caster: Node, target = null) -> void:
	var true_target = target if target else GameManager.find_nearest_enemy(caster)
	if not true_target:
		return
	await caster.get_tree().create_timer(3.0).timeout
	if is_instance_valid(true_target) and true_target.has_method("on_hurt"):
		true_target.on_hurt(GameManager.player_killer_queen_damage)
