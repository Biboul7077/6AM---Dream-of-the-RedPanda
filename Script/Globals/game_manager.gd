extends Node



@export_group("Global Variables")
@export var is_player_detected: bool = false
@export var is_shop_opened: bool = false
@export var global_diffuclty: int = 0

var game_menu_screen = preload("uid://b14lugt2ladmn")
var player_scene_root_path: String = "/root/MainScene/GameRoot/Player"

signal difficulty_increased

func start_game() -> void:
	SceneManager.load_main_scene_container()
	SceneManager.load_level("Level1")
	StatisticsManager.initialize_statistic()

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
