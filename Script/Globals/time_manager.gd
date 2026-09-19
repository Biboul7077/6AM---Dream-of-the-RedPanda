extends Node

const MINUTES_PER_DAY: int = 24*60
const MINUTES_PER_HOUR: int = 60
const GAME_MINUTE_DURATION: float = TAU / MINUTES_PER_DAY

var initial_hour: int = 0
var initial_minute: int = 0
var time: float = 0.0
var current_minute: int = -1
var difficulty_changed = false
var reasons: Dictionary[StringName, bool] = {}
var tokens: Dictionary[StringName, int] = {}
var next_token: int = 0

signal game_time(time: float)
signal time_tick(hour: int, minute: int)
signal timestop_changed(stopped: bool)

var timestop: bool:
	get:
		return not reasons.is_empty()


func _ready() -> void:
	set_initial_time()

func _process(delta: float) -> void:
	if !timestop:
		time += delta * GameManager.game_speed * GAME_MINUTE_DURATION
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
		difficulty_changed = true
	
	if minute == initial_minute + 2 and hour != initial_hour:
		difficulty_changed = false


func pause(_reason: StringName) -> void:
	if reasons.has(_reason):
		return  # idempotent : appuyer deux fois sur E dans la boutique ne cumule rien
	var was_stopped := timestop
	reasons[_reason] = true
	if not was_stopped:
		timestop_changed.emit(true)


func resume(_reason: StringName) -> void:
	if not reasons.erase(_reason):
		return
	if not timestop:
		timestop_changed.emit(false)


## Pause temporaire (Za Warudo). Un second appel avec la même raison
## prolonge la pause, et l'ancien timer ne la coupera pas trop tôt.
func pause_for(_reason: StringName, _duration: float) -> void:
	pause(_reason)
	next_token += 1
	var token := next_token
	tokens[_reason] = token
	await get_tree().create_timer(_duration).timeout
	if tokens.get(_reason) == token:
		resume(_reason)


func is_stopped_except(_reason: StringName) -> bool:
	for r in reasons:
		if r != _reason:
			return true
	return false


func reset() -> void:
	var was_stopped := timestop
	reasons.clear()
	tokens.clear()
	if was_stopped:
		timestop_changed.emit(false)
