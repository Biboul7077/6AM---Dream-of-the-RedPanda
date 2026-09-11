extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var knocked_out_state_time_interval : float = 5.0
@export var speed : int = 120
@export var distance : int = 60
@export var audio_stream_player_2d : AudioStreamPlayer2D

@onready var knocked_out_state_timer : Timer = Timer.new()

var knocked_out_state_timeout : bool = false
var direction : Vector2
var initial_position : Vector2

func _ready() -> void:
	knocked_out_state_timer.wait_time = knocked_out_state_time_interval
	knocked_out_state_timer.timeout.connect(on_knocked_out_state_timeout)

	add_child(knocked_out_state_timer)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	direction = -player.player_input_direction
	player.can_slash = false
	
	if player.global_position.distance_to(initial_position) < distance:
		player.velocity = direction * speed
		player.move_and_slide()


func _on_next_transitions() -> void:
	if knocked_out_state_timeout:
		transition.emit("Idle")


func _on_enter() -> void:
	audio_stream_player_2d.play()
	knocked_out_state_time_interval = GameManager.player_recovery_time
	animated_sprite_2d.play("KnockedOut")
	initial_position = player.global_position
	knocked_out_state_timeout = false
	knocked_out_state_timer.start()


func _on_exit() -> void:
	knocked_out_state_timeout = true
	player.can_slash = true


func on_knocked_out_state_timeout() -> void:
	knocked_out_state_timeout = true
