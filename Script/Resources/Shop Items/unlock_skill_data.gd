class_name SkillUnlock
extends ShopItem

@export_group("Skill")
@export var skill: Skill

func can_be_purchased(target: Node = null) -> bool:
	if skill == null:
		return false
	if GameManager.player_skills.has(skill):
		return false
	return GameManager.player_skills.has(SkillManager.NOSKILL)

func apply(target: Node = null) -> void:
	var slot_index := GameManager.player_skills.find(SkillManager.NOSKILL)
	if slot_index == -1:
		push_warning("Aucun slot libre pour le sort: %s" % skill.skill_name)
		return
	GameManager.player_skills[slot_index] = skill
	SkillManager.current_skill_list = GameManager.player_skills
