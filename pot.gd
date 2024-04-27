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
var totalWater:float = 0;
var waterAvg:float;
var waterHealth:float = 0.75
var waterLB:float = GameVariables.waterNeedsList[number][0]
var waterUB:float = GameVariables.waterNeedsList[number][1]
var waterTypical:float = GameVariables.waterNeedsList[number][2]

# Temperature variables
var currentTemp = GameVariables.temperature
var tempHealth = 0.75;
var tempLB:float = GameVariables.tempRanges[number][0]
var tempUB:float = GameVariables.tempRanges[number][1]
var tempTypical:int = GameVariables.tempRanges[number][2]
var tempConst = GameVariables.tempConst

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
	totalWater = totalWater +1
	#print(wateredNum)
	print(totalWater)
	 

func reset_wateredNum():
	wateredNum=0

func change_temp_health():
	if(currentTemp>= tempLB and currentTemp<=tempUB):
		if tempHealth >=(1-tempConst):
			tempHealth = 1
		else:
			tempHealth = tempHealth+tempConst
	else:
		var diff
		if(currentTemp<tempLB):
			diff = tempLB-currentTemp
		else:
			diff = currentTemp-tempUB
		tempHealth = tempHealth-(diff*diff*tempConst/25)

# Changes the water component of the health
func change_water_health():
	waterAvg = totalWater/ GameVariables.days_passed
	if(waterAvg>= waterLB and waterAvg<=waterUB):
		if waterHealth >=(1-waterConst):
			waterHealth = 1
		else:
			waterHealth = waterHealth+waterConst
	else:
		if(waterHealth<=(waterConst)):
			waterHealth = GameVariables.zero
		else:
			var diff = abs(waterAvg-waterTypical)			
			if(diff<1 ):
				waterHealth -= waterConst
			else:
				waterHealth-= 2*waterConst
			
		
	
# Change Health with average 
func change_Health():
	print("Old Health for Pot" +str(number)+": "+ str(health))
	change_water_health()
	change_temp_health()
	print("Total Wateer: " + str(totalWater))
	print("Total Days: "+ str(GameVariables.days_passed))
	print("Water per Day: " + str(waterAvg))
	print("Times Watered Today: "+ str(wateredNum))
	print("Temperature Health: "+ str(tempHealth))
	print("Temperature Lower Bound: "+ str(tempLB))
	print("Temperature Upper Bound: "+ str(tempUB))
	#print("Water Lower Bound: "+ str(waterLB))
	#print("Upper Bound: "+ str(waterUB))
	health = waterHealth*0.5 +tempHealth*0.5
	print("New Health for Pot" +str(number)+": "+ str(health))



 # Change Health with discrete math
#func change_Health():
	#print("Old Health for Pot" +str(number)+": "+ str(health))
	#print("Water Need: " + str(waterNeed))
	#print("Water Num: "+ str(wateredNum))
	#if wateredNum == waterNeed:
		#if health>=(1-waterConst):
			#health = 1
		#else:
			#health= health+waterConst
	#else:
		#var diff = abs(wateredNum-waterNeed)
		#var newMult = waterConst*diff
		#health = health - newMult
		#if health<0:
			#health = 0
			#
	#print("New Health for Pot" +str(number)+": "+ str(health))

