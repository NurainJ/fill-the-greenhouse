extends Node

var current_scene : String
var previous_scene : String

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	current_scene = "res://start_screen.tscn"
	

func set_scene(path):
	call_deferred("_deferred_goto_scene", path)

func set_scene_back():
	call_deferred("_deferred_goto_previous")

func _deferred_goto_scene(path: String):
	get_tree().change_scene_to_file(path)
	
	previous_scene = current_scene
	current_scene = path

func _deferred_goto_previous():
	get_tree().change_scene_to_file(previous_scene)
	
	var temp = current_scene
	current_scene = previous_scene
	previous_scene = temp
