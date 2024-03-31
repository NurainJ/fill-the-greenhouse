extends Area2D
var active = false
var frontShowing = true

# Called when the node enters the scene tree for the first time.
func _ready():
	SwipeDetector.connect("swipeRight", swipe_right.bind())
	SwipeDetector.connect("swipeLeft", swipe_left.bind())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_input_event(_viewport, event, _shape_idx):
	if !SwipeDetector.swipe and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if active:
			if frontShowing:
				$AnimationPlayer.play("flip_backward")
			else:
				$AnimationPlayer.play("flip_forward")
			frontShowing = !frontShowing
		else:
			active = true
			$AnimationPlayer.play("foreground")

func swipe_right(): 
	$AnimationPlayer.play("swipe_right")
	
func swipe_left():
	print("left")
