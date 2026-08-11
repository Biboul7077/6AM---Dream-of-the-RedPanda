class_name GameInputEvents

static var direction : Vector2

static func movement_input() -> Vector2:
	direction = Input.get_vector("KeyLeft", "KeyRight", "KeyUp", "KeyDown")
	
	return direction

static func skill_input() -> int:
	var skill_value: int
	if Input.is_action_just_pressed("keySpell1"):
		skill_value = 0
	elif Input.is_action_just_pressed("keySpell2"):
		skill_value = 1
	elif Input.is_action_just_pressed("keySpell3"):
		skill_value = 2
	else:
		skill_value = -1
	
	return skill_value

static func snap_to_cardinal(dir: Vector2) -> Vector2:
	if abs(dir.x) > abs(dir.y):
		return Vector2(sign(dir.x), 0)
	return Vector2(0, sign(dir.y))

static func is_movement_input() -> bool:
	if direction == Vector2.ZERO:
		return false
	else:
		return true

static func attack() -> bool:
	var attack_value : bool = Input.is_action_just_pressed("keyAttack")
	
	return attack_value

static func dodge() -> bool:
	var dodge_value : bool = Input.is_action_just_pressed("KeyDodge")
	
	return dodge_value
