extends Node

const ZAWARUDO = preload("uid://bbnnpf8rnn2oj")
const MADEINHEAVEN = preload("uid://dt7pwqyp4ydhq")
const KILLERQUEEN = preload("uid://cbchbnydjt1ef")
const NOSKILL = preload("uid://g3cfufofkf58")

signal cast_started(skill: Skill)
signal cast_finished(skill: Skill)
signal cast_failed(skill: Skill, reason: String)
signal cooldown_updated(skill: Skill, time_remaining: float)

@export var current_skill_list: Array[Skill] = StatisticsManager.player_skills
@export var recharging: Dictionary = {}

var is_casting: bool = false
var current_skill: Skill = null

func _ready() -> void:
	print(current_skill_list)

func _process(delta: float) -> void:
	for skill in recharging.keys().duplicate():
		recharging[skill] = max(0.0, recharging[skill] - delta)
		cooldown_updated.emit(skill, recharging[skill])
		if recharging[skill] <= 0.0:
			recharging.erase(skill)
			print("spell ready")


func can_cast(skill: Skill) -> bool:
	if is_casting:
		return false
	if recharging.has(skill):
		return false
	return true


func cast(caster: Node2D, skill: Skill, target = null) -> bool:
	if not can_cast(skill):
		var reason := "inconnue"
		if is_casting:
			reason = "déjà en incantation"
		elif recharging.has(skill):
			reason = "en recharge"
		cast_failed.emit(skill, reason)
		return false
	
	current_skill = skill
	cast_started.emit(skill)
	
	if skill.cast_cooldown > 0.0:
		is_casting = true
		await get_tree().create_timer(skill.cast_cooldown).timeout
		is_casting = false
	
	skill.executer(caster, target)
	recharging[skill] = skill.rest_cooldown
	cooldown_updated.emit(skill, skill.rest_cooldown)  # <-- ajouté
	cast_finished.emit(skill)
	current_skill = null
	return true


func cooldown_reset() -> void:
	print(recharging)
	recharging.clear()
	print(recharging)


func recharging_time_remaining(skill: Skill) -> float:
	return recharging.get(skill, 0.0)
