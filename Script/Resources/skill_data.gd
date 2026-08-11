class_name Skill
extends Resource

## --- Metadata ---
@export_group("Metadata")
@export var skill_name: String
@export var description: String
@export var icon: Texture2D

## --- Effects ---
@export_group("Effects")
@export var cast_cooldown: int
@export var rest_cooldown: int

func executer(caster: Node, target = null) -> void:
	push_warning("Spell.executer() n'a pas été implémenté pour : " + skill_name)
