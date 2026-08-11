extends Node

@export_group("Player Stats")
@export var player_damage: int
@export var player_speed: float
@export var player_recovery_time: float
@export var player_speed_boost: float
@export var player_time_stop_duration: float
@export var player_killer_queen_damage: int
@export var player_skills: Array[Skill]

@export_group("Enemy Stats")
@export var enemy_speed: float
@export var enemy_maximum_damage: int

func initialize_statistic():
	player_damage = 1
	player_recovery_time = 5.0
	player_speed = 120
	player_skills = []
	player_speed_boost = 1.0
	player_killer_queen_damage = 3.0
	player_time_stop_duration = 15.0
	enemy_maximum_damage = 5.0
	enemy_speed = 110.0
