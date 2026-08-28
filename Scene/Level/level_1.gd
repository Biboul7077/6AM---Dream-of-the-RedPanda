class_name LevelGenerator
extends Node2D

const TILED_ROOM_DIMENSION: Vector2i = Vector2i(16,16)
const TILE_DIMENSION: Vector2i = Vector2i(32,32)
const START_ROOM = preload("uid://c41gy7vyee50d")
const REGULAR_ROOM = preload("uid://dgnyiq4e25qjm")
const BED_ROOM = preload("uid://dq5mloqwxn65r")
const FOREST_ROOM = preload("uid://3n7tew23rhme")

@export var dimensions: Vector2i = Vector2i(7, 5)
@export var core_border: Vector2i = Vector2i(2, 1)
@export var start: Vector2i = Vector2i(-1, -1)
@export var critical_path_length: int = 13
@export var branches: int = 3
@export var branch_length: Vector2i = Vector2i(1, 4)

var level: Array
var connections: Array
var branch_candidates: Array[Vector2i]
var room_dimension: Vector2i = TILE_DIMENSION * TILED_ROOM_DIMENSION
var level_dimension: Vector2i = room_dimension * dimensions


func _ready() -> void:
	initialize_level()
	place_starting_room()
	generate_path(start,critical_path_length, "C")
	generate_branches()
	generate_rooms()


func initialize_level() -> void:
	for x in dimensions.x:
		level.append([])
		connections.append([])
		for y in dimensions.y:
			level[x].append(0)
			connections[x].append(0)


func place_starting_room() -> void:
	if start.x < 0 or start.x >= dimensions.x:
		start.x = randi_range(core_border.x, dimensions.x - core_border.x - 1)
	if start.y < 0 or start.y >= dimensions.y:
		start.y = randi_range(core_border.y, dimensions.y - core_border.y - 1)
	level[start.x][start.y] = "S"


func generate_path(from: Vector2i, length: int, marker: String) -> bool:
	if length == 0:
		return true
	var current: Vector2i = from
	var direction: Vector2i
	match randi_range(0, 3):
		0:
			direction = Vector2i.UP
		1:
			direction = Vector2i.RIGHT
		2:
			direction = Vector2i.DOWN
		3:
			direction = Vector2i.LEFT
	
	for i in 4:
		var next: Vector2i = current + direction
		if (next.x >= 0 and next.x < dimensions.x and
		next.y >= 0 and next.y < dimensions.y and
		not level[next.x][next.y]):
			level[next.x][next.y] = marker
			set_connection(current, next, true)
			if length > 1:
				branch_candidates.append(next)
			else:
				if marker == "C":
					level[next.x][next.y] = "E"
			if generate_path(next, length - 1, marker):
				return true
			else:
				branch_candidates.erase(next)
				set_connection(current, next, false)
				level[next.x][next.y] = 0
		direction = Vector2i(direction.y, -direction.x)
	return false


func generate_branches() -> void:
	var branches_created: int = 0
	var candidate: Vector2i
	
	while branches_created < branches and branch_candidates.size():
		candidate = branch_candidates.pick_random()
		if generate_path(candidate, randi_range(branch_length.x, branch_length.y), "B"+str(branches_created+1)):
			branches_created += 1
		else:
			branch_candidates.erase(candidate)


## Traduit un déplacement d'une case (delta) en direction DataTypes.Dir.
## y+1 = plus bas à l'écran = sud, y-1 = plus haut à l'écran = nord.
func dir_from_delta(delta: Vector2i) -> int:
	if delta == Vector2i(0, 1):
		return DataTypes.Dir.SOUTH
	elif delta == Vector2i(0, -1):
		return DataTypes.Dir.NORTH
	elif delta == Vector2i(1, 0):
		return DataTypes.Dir.EAST
	elif delta == Vector2i(-1, 0):
		return DataTypes.Dir.WEST
	return 0


func opposite_dir(dir: int) -> int:
	match dir:
		DataTypes.Dir.SOUTH:
			return DataTypes.Dir.NORTH
		DataTypes.Dir.NORTH:
			return DataTypes.Dir.SOUTH
		DataTypes.Dir.EAST:
			return DataTypes.Dir.WEST
		DataTypes.Dir.WEST:
			return DataTypes.Dir.EAST
	return 0


## Pose (add = true) ou retire (add = false) la connexion entre deux cases
## réellement adjacentes sur le chemin de génération. C'est ça qui garantit
## que seules les salles "vraiment" reliées entre elles portent une porte
## commune, contrairement à un scan de voisinage post-génération qui
## connecterait aussi les salles simplement collées par hasard.
func set_connection(a: Vector2i, b: Vector2i, add: bool) -> void:
	var dir_a: int = dir_from_delta(b - a)
	var dir_b: int = opposite_dir(dir_a)
	if add:
		connections[a.x][a.y] |= dir_a
		connections[b.x][b.y] |= dir_b
	else:
		connections[a.x][a.y] &= ~dir_a
		connections[b.x][b.y] &= ~dir_b


func generate_rooms() -> void:
	var position: Vector2
	var start_position: Vector2
 
	for y in dimensions.y:
		for x in dimensions.x:
			position = Vector2(x, y) * Vector2(room_dimension)
			var mask: int = connections[x][y]
			var room_id: Node2D
 
			if level[x][y] is String:
				if level[x][y] == "S":
					room_id = START_ROOM.instantiate()
					start_position = position + Vector2(room_dimension) / 2
				elif level[x][y] == "E":
					room_id = BED_ROOM.instantiate()
				elif level[x][y]:
					room_id = REGULAR_ROOM.instantiate()
			else:
				room_id = FOREST_ROOM.instantiate()
 
			if room_id:
				room_id.global_position = position
				add_child(room_id)
				if room_id.has_method("configure"):
					room_id.configure(mask)
 
	GameManager.initialize_player_position(start_position)
