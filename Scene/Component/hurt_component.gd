class_name HurtComponent
extends Area2D

signal hurt(hit_damage: int)

var invincible: bool = false
var _invincibility_token: int = 0


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _on_area_entered(area: Area2D) -> void:
	_try_hurt(area)


func _try_hurt(area: Area2D) -> void:
	if invincible:
		return
	var hit_component := area as HitComponent
	if hit_component == null:
		return
	GameManager.frame_freeze(0.0, 0.2)
	hurt.emit(hit_component.hit_damage * GameManager.player_damage)


## Invincible jusqu'à un appel à grant_invincibility().
func set_invincible(value: bool) -> void:
	_invincibility_token += 1
	invincible = value


## Invincible pendant `duration` secondes, puis on revérifie les hitboxes
## qui chevauchent encore le joueur (sinon elles seraient ignorées à jamais).
func grant_invincibility(duration: float) -> void:
	_invincibility_token += 1
	var token := _invincibility_token
	invincible = true
	await get_tree().create_timer(duration, true, false, true).timeout
	if token != _invincibility_token:
		return
	invincible = false
	for area in get_overlapping_areas():
		_try_hurt(area)
