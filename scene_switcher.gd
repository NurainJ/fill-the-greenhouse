extends Node


var previous_scene = {
	"res://start_screen.tscn": "res://start_screen.tscn", 
	"res://main_screen.tscn": "res://start_screen.tscn", 
	"res://calendar_screen.tscn": "res://main_screen.tscn", 
	"res://thermometer_screen.tscn": "res://main_screen.tscn", 
	"res://rack_screen.tscn": "res://workbench_screen.tscn", 
	"res://workbench_screen.tscn": "res://main_screen.tscn"}
var sceneNames = {}
	

# Called when the node enters the scene tree for the first time.
func _ready():
	sceneNames = {"res://start_screen.tscn": get_tree().root.get_node("Root/StartScreen"), 
	"res://main_screen.tscn": get_tree().root.get_node("Root/MainScreen"), 
	"res://calendar_screen.tscn": get_tree().root.get_node("Root/CalendarScreen"), 
	"res://thermometer_screen.tscn": get_tree().root.get_node("Root/ThermometerScreen"), 
	"res://rack_screen.tscn": get_tree().root.get_node("Root/RackScreen"), 
	"res://workbench_screen.tscn": get_tree().root.get_node("Root/WorkbenchScreen")}
	for scene in sceneNames:
		sceneNames[scene].visible = false
	sceneNames[GameVariables.current_scene].visible = true

func add_scene(path):
	pass

func set_scene(path):
	sceneNames[GameVariables.current_scene].visible = false
	sceneNames[path].visible = true
	sceneNames[path]._ready()
	GameVariables.current_scene = path
	$Timer.start()

func set_scene_back():
	sceneNames[GameVariables.current_scene].visible = false
	GameVariables.current_scene = previous_scene[GameVariables.current_scene]
	sceneNames[GameVariables.current_scene].visible = true
	sceneNames[GameVariables.current_scene]._ready()
	$Timer.start()
