extends Node

var temperature = 75
var days_remaining = 20
var activePlant = 0

var plantProperties = Array()

enum Species {LadySlipper, Pasque, WildYam}
enum Properties {currentState, species}

const LadySlipperNextScene = {"ladySlipper/ladySlipper0.svg": "ladySlipper/ladySlipper1.svg", 
				"ladySlipper/ladySlipper1.svg": "ladySlipper/ladySlipper2.svg", 
				"ladySlipper/ladySlipper2.svg": "ladySlipper/ladySlipper3.svg",
				"ladySlipper/ladySlipper3.svg": "ladySlipper/ladySlipper4.svg",
				"ladySlipper/ladySlipper4.svg": "ladySlipper/ladySlipper4.svg"}
const PasqueNextScene = {"pasque/pasque0.svg": "pasque/pasque1.svg", 
				"pasque/pasque1.svg": "pasque/pasque2.svg", 
				"pasque/pasque2.svg": "pasque/pasque3.svg", 
				"pasque/pasque3.svg": "pasque/pasque4.svg",
				"pasque/pasque4.svg": "pasque/pasque4.svg"}
const WildYamNextScene = {"wildYam/wildYam0.svg": "wildYam/wildYam1.svg", 
				"wildYam/wildYam1.svg": "wildYam/wildYam2.svg", 
				"wildYam/wildYam2.svg": "wildYam/wildYam3.svg", 
				"wildYam/wildYam3.svg": "wildYam/wildYam4.svg",
				"wildYam/wildYam4.svg": "wildYam/wildYam4.svg"}
								
const Base = "res://art/plant/"
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
