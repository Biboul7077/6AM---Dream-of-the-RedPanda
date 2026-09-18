extends Node

const NOSKILL = preload("uid://g3cfufofkf58")

@export_group("Player Stats")
@export var player_damage: float
@export var player_speed: float
@export var player_recovery_time: float
@export var player_speed_boost: float
@export var player_time_stop_duration: float
@export var player_killer_queen_damage: float
@export var player_skills: Array[Skill]

@export_group("Debug Variables")
@export var player_start_money: int = 0
@export var shopkeepers: bool = false
@export var game_speed: float = 4.0

@export_group("Enemy Stats")
@export var enemy_speed: float
@export var enemy_maximum_damage: float

@export_group("Global Variables")
@export var is_player_detected: bool = false
@export var is_shop_opened: bool = false
@export var global_diffuclty: int = 0

var game_menu_screen = preload("uid://b14lugt2ladmn")
var player_scene_root_path: String = "/root/MainScene/GameRoot/Player"

@warning_ignore("unused_signal")
signal difficulty_increased
signal game_started

func _ready() -> void:
	Engine.time_scale = 1.0

func start_game() -> void:
	initialize_statistic()
	SceneManager.load_main_scene_container()
	SceneManager.load_level("Level1")
	InventoryManager.add_collectable("KeoCoin", GameManager.player_start_money)
	game_started.emit()

func quit_game() -> void:
	get_tree().quit()

func show_game_menu_screen(victory: bool = false) -> void:
	TimeManager.timestop = true
	var game_menu_screen_instance = game_menu_screen.instantiate()
	var good_ending_screen = game_menu_screen_instance.find_child("GameOverScreenBackgroundGoodEnding")
	var bad_ending_screen = game_menu_screen_instance.find_child("GameOverScreenBackgroundBadEnding")
	if victory:
		good_ending_screen.visible = true
	else:
		bad_ending_screen.visible = true
	SceneManager.free_main_scene_container()
	get_tree().root.add_child(game_menu_screen_instance)


func initialize_player_position(pos: Vector2i):
	var player = get_tree().root.get_node(player_scene_root_path)
	player.global_position = pos

func find_nearest_enemy(origin: Node2D) -> Node2D:
	var enemies = get_tree().get_nodes_in_group("enemies")
	var nearest: Node2D = null
	var distance_min: float = INF

	for enemy in enemies:
		if not is_instance_valid(enemy):
			continue
		var distance := origin.global_position.distance_squared_to(enemy.global_position)
		if distance < distance_min:
			distance_min = distance
			nearest = enemy

	return nearest

func initialize_statistic():
	player_damage = 1
	player_recovery_time = 5.0
	player_speed = 120
	player_skills = [NOSKILL,NOSKILL,NOSKILL]
	player_speed_boost = 1.0
	player_killer_queen_damage = 3.0
	player_time_stop_duration = 15.0
	enemy_maximum_damage = 5.0
	enemy_speed = 110.0

func frame_freeze(timescale: float, duration: float) -> void:
	Engine.time_scale = timescale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1.0
