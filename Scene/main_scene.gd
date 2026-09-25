extends Node

@onready var level_root: Node2D = $GameRoot/LevelRoot

func _ready() -> void:
	SceneManager.register_main_scene(self, level_root)


func _exit_tree() -> void:
	SceneManager.unregister_main_scene(self)
