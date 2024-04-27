extends Node


var previous_scene = {
	"res://start_screen.tscn": "res://start_screen.tscn", 
	"res://main_screen.tscn": "res://start_screen.tscn", 
	"res://calendar_screen.tscn": "res://main_screen.tscn", 
	"res://thermometer_screen.tscn": "res://main_screen.tscn", 
	"res://rack_screen.tscn": "res://workbench_screen.tscn", 
	"res://workbench_screen.tscn": "res://main_screen.tscn",
	"res://end_screen.tscn" : "res://main_screen.tscn"}
var sceneNames = {}
	

# Called when the node enters the scene tree for the first time.
func _ready():
	sceneNames = {"res://start_screen.tscn": get_tree().root.get_node("Root/StartScreen"), 
	"res://main_screen.tscn": get_tree().root.get_node("Root/MainScreen"), 
	"res://calendar_screen.tscn": get_tree().root.get_node("Root/CalendarScreen"), 
	"res://thermometer_screen.tscn": get_tree().root.get_node("Root/ThermometerScreen"), 
	"res://rack_screen.tscn": get_tree().root.get_node("Root/RackScreen"), 
	"res://workbench_screen.tscn": get_tree().root.get_node("Root/WorkbenchScreen"),
	"res://end_screen.tscn": get_tree().root.get_node("Root/EndScreen")}

	for scene in sceneNames:
		remove_child(sceneNames[scene])
	add_child(sceneNames[GameVariables.current_scene])

func add_scene(path):
	add_child(sceneNames[path])

func set_scene(path):
	add_child(sceneNames[path])
	sceneNames[path]._ready()
	remove_child(sceneNames[GameVariables.current_scene])
	GameVariables.current_scene = path
	$Timer.start()

func set_scene_back():
	remove_child(sceneNames[GameVariables.current_scene])
	GameVariables.current_scene = previous_scene[GameVariables.current_scene]
	add_child(sceneNames[GameVariables.current_scene])
	sceneNames[GameVariables.current_scene]._ready()
	$Timer.start()
