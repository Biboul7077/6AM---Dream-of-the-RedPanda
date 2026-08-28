extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var skill_index: int
@export var audio_stream_player_2d: AudioStreamPlayer2D

func _ready() -> void:
	pass

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	pass


func _on_enter() -> void:
	skill_index = GameInputEvents.skill_input()
	animated_sprite_2d.play("Cast")
	SkillManager.cast_finished.connect(_on_cast_finished, CONNECT_ONE_SHOT)
	SkillManager.cast_failed.connect(_on_cast_failed, CONNECT_ONE_SHOT)
	
	if not await SkillManager.cast(player, SkillManager.current_skill_list[skill_index]):
		return


func _on_exit() -> void:
	if SkillManager.cast_finished.is_connected(_on_cast_finished):
		SkillManager.cast_finished.disconnect(_on_cast_finished)
	if SkillManager.cast_failed.is_connected(_on_cast_failed):
		SkillManager.cast_failed.disconnect(_on_cast_failed)
		
 
func _on_cast_finished(_s: Skill) -> void:
	audio_stream_player_2d.play()
	transition.emit("Idle")
 
 
func _on_cast_failed(skill: Skill, reason: String) -> void:
	transition.emit("Idle")
