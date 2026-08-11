class_name RegularRoom
extends Node2D

@onready var door_north: Node2D = $Doors/North
@onready var door_south: Node2D = $Doors/South
@onready var door_east: Node2D = $Doors/East
@onready var door_west: Node2D = $Doors/West

@onready var collisions_north: TileMapLayer = $Doors/North/Objects
@onready var collisions_south: TileMapLayer = $Doors/South/Objects
@onready var collisions_east: TileMapLayer = $Doors/East/Objects
@onready var collisions_west: TileMapLayer = $Doors/West/Objects


func configure(connection_mask: int) -> void:
	var north_closed: bool = !bool(connection_mask & DataTypes.Dir.NORTH)
	var east_closed: bool = !bool(connection_mask & DataTypes.Dir.EAST)
	var south_closed: bool = !bool(connection_mask & DataTypes.Dir.SOUTH)
	var west_closed: bool = !bool(connection_mask & DataTypes.Dir.WEST)
	
	door_north.visible = north_closed
	collisions_north.collision_enabled = north_closed
	
	door_east.visible = east_closed
	collisions_east.collision_enabled = east_closed
	
	door_south.visible = south_closed
	collisions_south.collision_enabled = south_closed
	
	door_west.visible = west_closed
	collisions_west.collision_enabled = west_closed
