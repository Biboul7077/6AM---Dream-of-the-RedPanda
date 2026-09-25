extends PanelContainer
@onready var spell_1: Button = $MarginContainer/HBoxContainer/Spell1
@onready var spell_2: Button = $MarginContainer/HBoxContainer/Spell2
@onready var spell_3: Button = $MarginContainer/HBoxContainer/Spell3
var skill_list = GameManager.player_stats.skills

func _ready() -> void:
	SkillManager.skill_list_changed.connect(on_skill_list_changed)
	on_skill_list_changed()

	SkillManager.cooldown_updated.connect(_on_cooldown_updated)

func _on_cooldown_updated(skill: Skill, time_remaining: float) -> void:
	var bar := _get_bar_for_skill(skill)
	if bar == null:
		return
	if skill.rest_cooldown < 100.0:
		bar.value = (time_remaining / skill.rest_cooldown) * 100.0
	else:
		bar.value = 0.0

func _get_bar_for_skill(skill: Skill) -> TextureProgressBar:
	if skill_list[0] == skill:
		return spell_1.get_node("TextureProgressBar")
	elif skill_list[1] == skill:
		return spell_2.get_node("TextureProgressBar")
	elif skill_list[2] == skill:
		return spell_3.get_node("TextureProgressBar")
	return null

func _on_spell_1_pressed() -> void:
	Input.action_press("keySpell1")
func _on_spell_2_pressed() -> void:
	Input.action_press("keySpell2")
func _on_spell_3_pressed() -> void:
	Input.action_press("keySpell3")


func on_skill_list_changed():
	if skill_list[0] != null:
		spell_1.icon = skill_list[0].icon
	if skill_list[1] != null:
		spell_2.icon = skill_list[1].icon
	if skill_list[2] != null:
		spell_3.icon = skill_list[2].icon
