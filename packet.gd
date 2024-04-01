extends Area2D
var active = false
var frontShowing = true
@export var order:int #1 denotes front, 3 denotes back
@export var species:GameVariables.Species

# Called when the node enters the scene tree for the first time.
func _ready():
	SwipeDetector.connect("swipeRight", swipe_right.bind())
	SwipeDetector.connect("swipeLeft", swipe_left.bind())
	if order == 1:
		z_index = 4
	elif order == 2:
		z_index = 2
	elif order == 3:
		z_index = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_input_event(viewport, event, _shape_idx):
	if event is InputEventMouseButton and !event.pressed and !SwipeDetector._calculate_swipe(viewport.get_mouse_position()):
		if active:
			if frontShowing:
				$AnimationPlayer.play("flip_backward")
			else:
				$AnimationPlayer.play("flip_forward")
			frontShowing = !frontShowing
		elif order == 1:
			active = true
			$AnimationPlayer.play("foreground")

func swipe_right(): 
	$AnimationPlayer.play("swipe_right")
	await $AnimationPlayer.animation_finished
	GameVariables.plantStates[GameVariables.activePlant] = GameVariables.possiblePlantStates[GameVariables.speciesNames[species] + "0"]
	SceneSwitcher.set_scene("res://workbench_screen.tscn")
	queue_free()
	
func swipe_left():
	if order == 1:
		$AnimationPlayer.play("swipe_left")
		await $AnimationPlayer.animation_finished
		get_parent().move_child(self, 1)
		order = 3
	elif order == 2:
		$AnimationPlayer.play("move_to_front")
		await $AnimationPlayer.animation_finished
		order = 1
	elif order == 3:
		$AnimationPlayer.play("move_to_middle")
		await $AnimationPlayer.animation_finished
		active = false
		order = 2
