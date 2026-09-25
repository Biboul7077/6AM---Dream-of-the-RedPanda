extends Node

var main_scene_path :String = "res://Scene/main_scene.tscn"

var level_scenes:Dictionary = {
	"Level1" : "res://Scene/Level/level_1.tscn"
}

var main_scene: Node = null
var level_root: Node = null


func load_main_scene_container() -> void:
	if main_scene != null:
		return
	
	var node:Node = load(main_scene_path).instantiate()
	
	if node != null:
		get_tree().root.add_child(node)


func register_main_scene(_main_scene: Node, _level_root: Node) -> void:
	main_scene = _main_scene
	level_root = _level_root


func unregister_main_scene(_main_scene: Node) -> void:
	if _main_scene == main_scene:
		main_scene = null
		level_root = null


func load_level(level:String) -> void:
	var scene_path:String = level_scenes.get(level)
	if scene_path == null or level_root == null:
		return
	
	var level_scene:Node = load(scene_path).instantiate()

	for node: Node in level_root.get_children():
		node.queue_free()
	await get_tree().process_frame
	
	level_root.add_child(level_scene)


func free_main_scene_container():
	if main_scene:
		main_scene.queue_free()
