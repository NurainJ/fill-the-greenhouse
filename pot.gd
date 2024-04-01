extends Area2D

var number : int;


# Called when the node enters the scene tree for the first time.
func _ready():
	$plant.set_texture(load(GameVariables.plantStates[number].path))
	$soil.set_texture(load(GameVariables.soilPaths[number]))
	get_parent().get_node("BlackScreen/BlackScreenPlayer").connect("is_black", _animation_finished.bind())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GameVariables.activePlant = number
		SceneSwitcher.set_scene("res://workbench_screen.tscn")
		queue_free()


func _animation_finished():
	GameVariables.plantStates[number] = GameVariables.plantStates[number].get_next_state()
	$plant.set_texture(load(GameVariables.plantStates[number].path))