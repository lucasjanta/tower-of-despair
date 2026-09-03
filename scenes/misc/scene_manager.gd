class_name SceneManager extends Node

@export var world_2D: Node2D
@export var gui: Control

var current_2D_scene: Node
var current_gui_scene: Node

var scene_cache: Dictionary = {} # Store loaded scenes by path

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.scene_manager = self
	current_gui_scene = $CanvasLayer/UI/main_menu
	current_2D_scene = $world_2d/TowerMenu
	
	if current_gui_scene and current_gui_scene.scene_file_path:
		scene_cache[current_gui_scene.scene_file_path] = current_gui_scene

func change_gui_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_gui_scene != null:
		if delete:
			var scene_path := current_gui_scene.scene_file_path
			current_gui_scene.queue_free() # Removes node entirely
			scene_cache.erase(scene_path)
		elif keep_running:
			current_gui_scene.visible = false # Keeps in memory and runnings
		else:
			gui.remove_child(current_gui_scene) # Keeps in memory, does not run
	
	var new_node: Node
	if scene_cache.has(new_scene):
		new_node = scene_cache[new_scene]
		if new_node.get_parent() == null:
			gui.add_child(new_node)
		new_node.visible = true
	else:
		new_node = load(new_scene).instantiate()
		scene_cache[new_scene] = new_node
		gui.add_child(new_node)
	
	current_gui_scene = new_node


func change_2D_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_2D_scene != null:
		if delete:
			var scene_path := current_2D_scene.scene_file_path
			current_2D_scene.queue_free() # Removes node entirely
			scene_cache.erase(scene_path)
		elif keep_running:
			current_2D_scene.visible = false # Keeps in memory and runnings
		else:
			world_2D.remove_child(current_2D_scene) # Keeps in memory, does not run
	
	
	var new_node: Node
	if scene_cache.has(new_scene):
		new_node = scene_cache[new_scene]
		if new_node.get_parent() == null:
			world_2D.add_child(new_node)
		new_node.visible = true
	else:
		new_node = load(new_scene).instantiate()
		scene_cache[new_scene] = new_node
		world_2D.add_child(new_node)
	
	current_2D_scene = new_node
	
