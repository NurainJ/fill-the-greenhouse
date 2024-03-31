extends Label



# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(str(GameVariables.temperature))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func increase_temp():
	if GameVariables.temperature < 99:
		GameVariables.temperature += 1
		set_text(str(GameVariables.temperature))


func decrease_temp():
	if GameVariables.temperature > 32:
		GameVariables.temperature -= 1
		set_text(str(GameVariables.temperature))
	

func _on_up_button_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		increase_temp()


func _on_down_button_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		decrease_temp()
