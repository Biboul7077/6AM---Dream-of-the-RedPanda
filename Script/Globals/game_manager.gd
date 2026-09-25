extends Node

var player_stats: PlayerStats = PlayerStats.new()
var enemy_stats: EnemyStats = EnemyStats.new()

@export_group("Debug Variables")
@export var player_start_money: int = 0
@export var shopkeepers: bool = false
@export var game_speed: float = 4.0


@export_group("Global Variables")
var detection_count: int = 0
var is_player_detected: bool:
	get:
		return detection_count > 0
var global_diffuclty: int = 0
var is_shop_opened: bool = false:
	set(value):
		if is_shop_opened == value:
			return
		is_shop_opened = value
		shop_state_changed.emit(value)

var game_menu_screen = preload("uid://b14lugt2ladmn")


signal game_started
signal shop_state_changed(opened: bool)


func _ready() -> void:
	Engine.time_scale = 1.0

func start_game() -> void:
	initialize_statistics()
	SceneManager.load_main_scene_container()
	SceneManager.load_level("Level1")
	InventoryManager.add_collectable("KeoCoin", GameManager.player_start_money)
	game_started.emit()

func quit_game() -> void:
	get_tree().quit()

func show_game_menu_screen(victory: bool = false) -> void:
	TimeManager.reset()
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
	var player = get_tree().get_first_node_in_group("player")
	if player:
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


func initialize_statistics() -> void:
	detection_count = 0
	player_stats.reset_stats()
	enemy_stats.reset_stats()


func frame_freeze(timescale: float, duration: float) -> void:
	Engine.time_scale = timescale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1.0


func mark_player_detected() -> void:
	detection_count += 1


func clear_player_detection() -> void:
	detection_count = max(0, detection_count - 1)
