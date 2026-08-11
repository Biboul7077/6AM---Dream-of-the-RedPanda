extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed : int = 120
@export var dodge_state_time_interval : float = 5.0

@onready var dodge_state_timer : Timer = Timer.new()
@onready var dodge_state_trail : Line2D = Line2D.new()

var dodge_state_timeout : bool = false
var direction : Vector2

func _ready() -> void:
	dodge_state_timer.wait_time = dodge_state_time_interval
	dodge_state_timer.timeout.connect(on_dodge_state_timeout)
	dodge_state_trail.default_color = Color(0.75, 0.69, 1, 1)
	dodge_state_trail.width_curve = preload("uid://4pednxcbf36b")
	dodge_state_trail.y_sort_enabled = true

	add_child(dodge_state_timer)
	add_child(dodge_state_trail)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	direction = player.player_input_direction
	dodge_state_trail.add_point(player.global_position+Vector2(0,-13))
	
	player.velocity = direction * speed
	player.move_and_slide()


func _on_next_transitions() -> void:
	if dodge_state_timeout:
		transition.emit("Idle")


func _on_enter() -> void:
	dodge_state_timeout = false
	dodge_state_timer.start()


func _on_exit() -> void:
	dodge_state_timeout = true
	dodge_state_trail.clear_points()

func on_dodge_state_timeout() -> void:
	dodge_state_timeout = true
