extends Area2D
const NextScene = {"potSoilFull.svg": "lsBaby.svg", 
				"lsBaby.svg": "lsBud.svg", 
				"lsBud.svg": "lsLeaves.svg",
				"lsLeaves.svg": "lsFull.svg",
				"lsFull.svg": "lsFull.svg"}
const Base = "res://art/workbenchScreen/"
var number : int;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.set_texture(load(Base + GameVariables.currentPlantState[number]))
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
	if (is_growing()):
		GameVariables.currentPlantState[number] = NextScene.get(GameVariables.currentPlantState[number])
		$Sprite2D.set_texture(load(Base + GameVariables.currentPlantState[number]))

func is_growing() -> bool: 
	return RandomNumberGenerator.new().randi_range(0,10) == 0
