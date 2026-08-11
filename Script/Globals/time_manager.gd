extends Node

const MINUTES_PER_DAY: int = 24*60
const MINUTES_PER_HOUR: int = 60
const GAME_MINUTE_DURATION: float = TAU / MINUTES_PER_DAY

var game_speed: float = 5.0

var initial_hour: int = 0
var initial_minute: int = 0

var time: float = 0.0
var timestop: bool = true
var current_minute: int = -1

var difficulty_changed = false

signal game_time(time: float)
signal time_tick(hour: int, minute: int)

func _ready() -> void:
	set_initial_time()

func _process(delta: float) -> void:
	if !timestop:
		time += delta * game_speed * GAME_MINUTE_DURATION
	game_time.emit(time)
	
	recalculate_time()

func set_initial_time() -> void:
	var initial_total_minute = initial_hour * MINUTES_PER_HOUR + initial_minute
	
	time = initial_total_minute * GAME_MINUTE_DURATION

func recalculate_time() -> void:
	var total_minutes: int = int(time / GAME_MINUTE_DURATION)
	var current_day_minutes: int = total_minutes % MINUTES_PER_DAY
	var hour: int = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute: int = current_day_minutes % MINUTES_PER_HOUR
	
	if current_minute != minute:
		current_minute = minute
		time_tick.emit(hour, minute)
	
	if hour == 6:
		set_initial_time()
		SkillManager.cooldown_reset()
		GameManager.show_game_menu_screen()
	
	
	if minute == initial_minute and hour != initial_hour and !difficulty_changed:
		GameManager.increase_diffuclty()
		difficulty_changed = true
	
	if minute == initial_minute + 2 and hour != initial_hour:
		difficulty_changed = false
	
	
