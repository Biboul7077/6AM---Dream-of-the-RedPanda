extends Node

var main_scene_path :String = "res://Scene/main_scene.tscn"
var main_scene_level_root:String = "/root/MainScene"
var main_scene_level_root_path : String = "/root/MainScene/GameRoot/LevelRoot"

var level_scenes:Dictionary = {
	"Level1" : "res://Scene/Level/level_1.tscn"
}

func load_main_scene_container() -> void:
	if get_tree().root.has_node(main_scene_level_root):
		return
	
	var node:Node = load(main_scene_path).instantiate()
	
	if node != null:
		get_tree().root.add_child(node)
		
func load_level(level:String) -> void:
	var scene_path:String = level_scenes.get(level)
	
	if scene_path ==null:
		return
	
	var level_scene:Node = load(scene_path).instantiate()
	var level_root:Node = get_node(main_scene_level_root_path)

	if level_root !=null:
		var nodes = level_root.get_children()
		
		if nodes!=null:
			for node: Node in nodes:
				node.queue_free()
				
		await get_tree().process_frame
	
	level_root.add_child(level_scene)

func free_main_scene_container():
	get_tree().root.get_node(main_scene_level_root).queue_free()
