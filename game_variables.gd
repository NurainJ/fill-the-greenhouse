extends Node

var temperature = 75
var days_remaining = 20
var activePlant = 0

var plantProperties = Array()

enum Species {LadySlipper, Pasque, WildYam}
enum Properties {currentState, species}

const LadySlipperNextScene = {"potSoilFull.svg": "lsBaby.svg", 
				"lsBaby.svg": "lsBud.svg", 
				"lsBud.svg": "lsLeaves.svg",
				"lsLeaves.svg": "lsFull.svg",
				"lsFull.svg": "lsFull.svg"}
const PasqueNextScene = {"potSoilFull.svg": "pasque1.svg", 
				"pasque1.svg": "pasque2.svg", 
				"pasque2.svg": "pasque3.svg", 
				"pasque3.svg": "pasqueFull.svg",
				"pasqueFull.svg": "pasqueFull.svg"}
const WildYamNextScene = {"potSoilFull.svg": "wildYam1.svg", 
				"wildYam1.svg": "wildYam2.svg", 
				"wildYam2.svg": "wildYam3.svg", 
				"wildYam3.svg": "wildYamFull.svg",
				"wildYamFull.svg": "wildYamFull.svg"}
								
const Base = "res://art/workbenchScreen/"
const NextScene = {Species.LadySlipper : LadySlipperNextScene, Species.Pasque : PasqueNextScene, Species.WildYam : WildYamNextScene}



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func getNextScene(plantNumber: int) -> String:
	var currentState = plantProperties[plantNumber][Properties.currentState]
	currentState = NextScene.get(plantProperties[plantNumber][Properties.species]).get(currentState)
	plantProperties[plantNumber][Properties.currentState] = currentState
	return currentState
