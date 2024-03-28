extends Node

var temperature = 75
var days_remaining = 20
var activePlant = 0

var plantStateClass = load("res://plant_state.gd")
var plantStates = Array()

enum Species {LadySlipper, Pasque, WildYam}

const BasePath = "res://art/plant/"

var ladySlipperInitialState = plantStateClass.new()
var pasqueInitialState = plantStateClass.new()
var wildYamInitialState = plantStateClass.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var initialStates = {ladySlipperInitialState: "/ladySlipper", pasqueInitialState: "/pasque", wildYamInitialState: "/wildYam"}
	
	for initialState in initialStates:
		var currentState
		var nextState = initialState
		var path = BasePath + initialStates[initialState]
		for i in range(5) :
			currentState = nextState
			currentState.species = Species.LadySlipper
			currentState.path = path + initialStates[initialState] + str(i) + ".svg"
			nextState = plantStateClass.new()
			currentState.nextState = nextState
		currentState.nextState = currentState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func getNextScene(plantNumber: int) -> String:
	return plantStates[plantNumber].nextState.path
