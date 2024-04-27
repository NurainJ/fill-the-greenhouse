extends Area2D

@export var number : int;

# Health variables
var wateredNum:int =0;
var yesWaterNum:int = 0;
var waterConst = GameVariables.waterConst
var waterNeed = GameVariables.waterNeeds[number]
var health:float = 0.75
var hasSeed

# average water model
var totalWater:int = 0;



# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("/root/Root/EndScreen").connect("is_black", _animation_finished.bind())

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update():

	$plant.set_texture(load(GameVariables.plantStates[number].path))
	$soil.set_texture(load(GameVariables.possibleSoilPaths[GameVariables.soilPathIndicies[number]]))

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GameVariables.activePlant = number
		get_tree().root.get_node("Root").set_scene("res://workbench_screen.tscn")


func _animation_finished():
	if(hasSeed):
		change_Health()
		reset_wateredNum()
	GameVariables.plantStates[number] = GameVariables.plantStates[number].get_next_state(health)
	$plant.set_texture(load(GameVariables.plantStates[number].path))


# Changing if there's a seed
func give_seed():
	hasSeed=true

# Health related functions
func increase_wateredNum():
	wateredNum=wateredNum+1
	print(wateredNum)
	
	
func testing():
	print("it gets the node.")


func reset_wateredNum():
	#yesWaterNum = wateredNum
	wateredNum=0

func change_Health():
	print("Old Health for Pot" +str(number)+": "+ str(health))
	print("Water Need: " + str(waterNeed))
	print("Water Num: "+ str(wateredNum))
	if wateredNum == waterNeed:
		if health>=(1-waterConst):
			health = 1
		else:
			health= health+waterConst
	else:
		var diff = abs(wateredNum-waterNeed)
		var newMult = waterConst*diff
		health = health - newMult
		if health<0:
			health = 0
			
	print("New Health for Pot" +str(number)+": "+ str(health))


#
#func change_Health():
	#print("Old Health for Pot" +str(number)+": "+ str(health))
	#print("Water Need: " + str(waterNeed))
	#print("Water Num: "+ str(yesWaterNum))
	#if yesWaterNum == waterNeed:
		#if health>=(1-waterConst):
			#health = 1
		#else:
			#health= health+waterConst
	#else:
		#var diff = abs(yesWaterNum-waterNeed)
		#var newMult = waterConst*diff
		#health = health - newMult
		#if health<0:
			#health = 0
			#
	#print("New Health for Pot" +str(number)+": "+ str(health))
		#
