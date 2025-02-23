extends Node2D
class_name SpawnPoint

enum SpawnPointTypes {
	CHARACTER,
	ROOM_INTERIOR,
	ROOM
}

@export var spawn_point_type: SpawnPointTypes
