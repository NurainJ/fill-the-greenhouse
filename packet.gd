extends Area2D
var active = false
var frontShowing = true
var isPlaying = false
@export var order:int #1 denotes front, 3 denotes back
@export var species:GameVariables.Species

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("../xMark").connect("input_event", Callable(self, "_on_xMark_input_event"))
	get_node("../checkMark").connect("input_event", Callable(self, "_on_checkMark_input_event"))
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
		if order == 1:
			isPlaying = true
			if !active: 
				$AnimationPlayer.play("foreground")
				await $AnimationPlayer.animation_finished
				active = true
			if frontShowing:
				$AnimationPlayer.play("flip_backward")
			else:
				$AnimationPlayer.play("flip_forward")
			await $AnimationPlayer.animation_finished
			isPlaying = false 
			frontShowing = !frontShowing
			
func _on_xMark_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		swipe_left()

func _on_checkMark_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		swipe_right()

func swipe_right(): 
	var rootNode = get_tree().root.get_node("Root")
	
	# To change the boolean of the pot to say it has a seed.
	get_tree().root.get_node("Root").add_scene("res://main_screen.tscn")
	var mainScreen = get_tree().root.get_node("Root/MainScreen")
	mainScreen.visible = false
	var currentPot = mainScreen.get_node("Pot"+str(GameVariables.activePlant))
	currentPot.give_seed()
	mainScreen.visible = true
	get_tree().root.get_node("Root").remove_child(mainScreen)
	
	if rootNode.get_node("Timer").is_stopped() and order == 1:
		isPlaying = true
		$AnimationPlayer.play("swipe_right")
		await $AnimationPlayer.animation_finished
		isPlaying = false
		GameVariables.plantStates[GameVariables.activePlant] = GameVariables.possiblePlantStates[GameVariables.speciesNames[species] + "0"]
		
		await rootNode.add_scene("res://workbench_screen.tscn")
		var player = get_tree().root.get_node("Root/WorkbenchScreen/rack/AnimationPlayer")
		player.play("plant_seeds")
		GameVariables.plantStates[GameVariables.activePlant].species = species
		GameVariables.plantStates[GameVariables.activePlant] = GameVariables.possiblePlantStates[GameVariables.speciesNames[species] + "0"]
		rootNode.set_scene("res://workbench_screen.tscn")
		$AnimationPlayer.play("RESET")
		await $AnimationPlayer.animation_finished

	

		
func swipe_left():
	if get_tree().root.get_node("Root/Timer").is_stopped():
		isPlaying = true
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
		isPlaying = false


func _input(_event: InputEvent):
	if isPlaying:
		get_viewport().set_input_as_handled()
