extends NodeState

@export var nightmare: Nightmare
@export var sprite_2d: Sprite2D
@export var knocked_out_state_time_interval: float = 0.4
@export var speed: float = 220.0
@export var distance: float = 60.0
@export var audio_stream_player_2d: AudioStreamPlayer2D

@onready var knocked_out_state_timer: Timer = Timer.new()

var knocked_out_state_timeout: bool = false
var direction: Vector2 = Vector2.ZERO
var initial_position: Vector2


func _ready() -> void:
	knocked_out_state_timer.one_shot = true
	knocked_out_state_timer.timeout.connect(on_knocked_out_state_timeout)
	add_child(knocked_out_state_timer)


func _on_physics_process(_delta: float) -> void:
	if nightmare.global_position.distance_to(initial_position) < distance:
		nightmare.velocity = direction * speed
		nightmare.move_and_slide()
	else:
		nightmare.velocity = Vector2.ZERO


func _on_next_transitions() -> void:
	if knocked_out_state_timeout:
		if nightmare.target != null:
			transition.emit("Chase")
		else:
			transition.emit("Idle")


func _on_enter() -> void:
	if audio_stream_player_2d:
		audio_stream_player_2d.play()

	initial_position = nightmare.global_position
	knocked_out_state_timeout = false

	if nightmare.target != null:
		direction = (nightmare.global_position - nightmare.target.global_position).normalized()
	else:
		direction = Vector2.ZERO

	if direction == Vector2.ZERO:
		direction = Vector2.RIGHT.rotated(randf() * TAU)

	knocked_out_state_timer.start(knocked_out_state_time_interval)


func _on_exit() -> void:
	nightmare.velocity = Vector2.ZERO
	knocked_out_state_timer.stop()


func on_knocked_out_state_timeout() -> void:
	knocked_out_state_timeout = true
