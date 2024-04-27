extends Node2D
const PotResouce = preload("res://pot.tscn")
var isInitialized = false

const PotPosition = [
	Vector2(-826, 154), 
	Vector2(-602, 67), 
	Vector2(-273, -4), 
	Vector2(3, -3), 
	Vector2(260, -6), 
	Vector2(595, 65), 
	Vector2(814, 154)]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	if !isInitialized:
		initializePots()
	for i in range(7):
		get_node("Pot" + str(i)).update()


func initializePots():
	for x in range(7):
			GameVariables.soilPathIndicies.append(0)
			GameVariables.plantStates.append(GameVariables.initialStates[GameVariables.Species.LadySlipper])
			
	isInitialized = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	$BlackScreen.fade_to_black()
	
	if GameVariables.days_remaining == 0:
		get_tree().root.get_node("Root").set_scene("res://end_screen.tscn")


func _on_next_day_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$BlackScreen.fade_to_black()
