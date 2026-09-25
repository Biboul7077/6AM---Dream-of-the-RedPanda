class_name PlayerStats
extends Resource


@export var damage: float = 1.0
@export var speed: float = 120.0
@export var recovery_time: float = 5.0
@export var speed_boost: float = 1.0
@export var time_stop_duration: float = 15.0
@export var killer_queen_damage: float = 3.0
@export var skills: Array[Skill] = [SkillManager.NOSKILL,SkillManager.NOSKILL,SkillManager.NOSKILL]

func reset_stats():
	damage = 1
	recovery_time = 5.0
	speed = 120
	skills = [SkillManager.NOSKILL,SkillManager.NOSKILL,SkillManager.NOSKILL]
	speed_boost = 1.0
	killer_queen_damage = 3.0
	time_stop_duration = 15.0
