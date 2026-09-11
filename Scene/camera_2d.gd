extends Camera2D

var shake_magnitude: float = 0.0
var shake_remain: float = 0.0
var shake_length: float = 1.0
var rng = RandomNumberGenerator.new()

func _process(_delta: float) -> void:
	offset = random_offset()
	
	shake_remain = max(0, shake_remain - ((1/shake_length) * shake_magnitude));


func screenshake(_magnitude,_frames):
	if _magnitude > shake_remain:
		shake_magnitude = _magnitude
		shake_remain = shake_magnitude
		shake_length = _frames

func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_remain,shake_remain),rng.randf_range(-shake_remain,shake_remain))
