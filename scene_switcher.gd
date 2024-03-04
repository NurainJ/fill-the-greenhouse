extends Node

var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	

func set_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	current_scene.free()
	
	var next_scene = ResourceLoader.load(path)
	
	current_scene = next_scene.instantiate()
	
	get_tree().root.add_child(current_scene)
	
	get_tree().current_scene = current_scene
