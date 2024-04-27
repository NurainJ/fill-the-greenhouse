extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.set_text(str(GameVariables.days_remaining))
	get_parent().get_node("BlackScreen/BlackScreenPlayer").connect("is_black", next_day.bind())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().root.get_node("Root").set_scene("res://calendar_screen.tscn")

func next_day():
	GameVariables.days_remaining -= 1
	GameVariables.days_passed += 1
	print("Day "+ str(GameVariables.days_passed))
	$Label.set_text(str(GameVariables.days_remaining))
