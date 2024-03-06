extends Node

var current_scene : String
var previous_scene = {
	"res://main_screen.tscn": "res://start_screen.tscn", 
	"res://calendar_screen.tscn": "res://main_screen.tscn", 
	"res://thermometer_screen.tscn": "res://main_screen.tscn", 
	"res://seed_box_screen.tscn": "res://main_screen.tscn", 
	"res://workbench_screen.tscn": "res://main_screen.tscn"}

# Called when the node enters the scene tree for the first time.
func _ready():
	current_scene = "res://start_screen.tscn"
	

func set_scene(path):
	call_deferred("_deferred_goto_scene", path)

func set_scene_back():
	call_deferred("_deferred_goto_previous")

func _deferred_goto_scene(path: String):
	get_tree().change_scene_to_file(path)
	
	current_scene = path

func _deferred_goto_previous():
	current_scene = previous_scene.get(current_scene)
	get_tree().change_scene_to_file(current_scene)
	
