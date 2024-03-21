extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.set_text(str(GameVariables.days_remaining))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		SceneSwitcher.set_scene("res://calendar_screen.tscn")
		queue_free()

func next_day():
	GameVariables.days_remaining -= 1
	$Label.set_text(str(GameVariables.days_remaining))
