extends Node

var temperature = 75
var days_remaining = 20
var activePlant = 0

var plantStateClass = load("res://plant_state.gd")
var plantStates = Array()
var possiblePlantStates = {}

enum Species {LadySlipper, Pasque, WildYam}
const speciesNames = {Species.LadySlipper: "ladySlipper", Species.Pasque: "pasque", Species.WildYam: "wildYam"}
const speciesPaths = {Species.LadySlipper: "res://art/plant/ladySlipper/", Species.Pasque: "res://art/plant/pasque/", Species.WildYam: "res://art/plant/wildYam/"}

var ladySlipperInitialState
var pasqueInitialState
var wildYamInitialState

var soilPaths = Array()
var possibleSoilPaths = ["res://art/pot/potSoilEmpty.svg", "res://art/pot/potSoilFull.svg", "res://art/pot/potSoilOverfull1.svg", "res://art/pot/potSoilOverfull2.svg"]

var currentPacket: Species

var stateMachineData = {Species.LadySlipper: {
						 "ladySlipperBlank": {}, 
							 "ladySlipper0": {"ladySlipper1": 0.42,                            "ladySlipperDead": 0.01}, 
							 "ladySlipper1": {"ladySlipper2": 0.3, "ladySlipper1Dying": 0.2, "ladySlipperDead": 0.01}, 
							 "ladySlipper2": {"ladySlipper3": 0.15, "ladySlipper2Dying": 0.10, "ladySlipperDead": 0.01}, 
							 "ladySlipper3": {"ladySlipper4": 0.05, "ladySlipper3Dying": 0.03, "ladySlipperDead": 0.01}, 
							 "ladySlipper4": {                     "ladySlipper4Dying": 0.1, "ladySlipperDead": 0.01}, 
						"ladySlipper1Dying": {"ladySlipper1": 0.5,                            "ladySlipperDead": 0.01}, 
						"ladySlipper2Dying": {"ladySlipper2": 0.5,                            "ladySlipperDead": 0.01}, 
						"ladySlipper3Dying": {"ladySlipper3": 0.5,                            "ladySlipperDead": 0.01}, 
						"ladySlipper4Dying": {"ladySlipper4": 0.5,                            "ladySlipperDead": 0.01}, 
						  "ladySlipperDead": {}}, 
						Species.Pasque: {
						 "pasqueBlank": {},
							 "pasque0": {"pasque1": 0.46,                       "pasqueDead": 0.01}, 
							 "pasque1": {"pasque2": 0.35, "pasque1Dying": 0.25, "pasqueDead": 0.01}, 
							 "pasque2": {"pasque3": 0.18, "pasque2Dying": 0.12, "pasqueDead": 0.01}, 
							 "pasque3": {"pasque4": 0.06, "pasque3Dying": 0.04, "pasqueDead": 0.01}, 
							 "pasque4": {                "pasque4Dying": 0.1, "pasqueDead": 0.01}, 
						"pasque1Dying": {"pasque1": 0.5,                       "pasqueDead": 0.01}, 
						"pasque2Dying": {"pasque2": 0.5,                       "pasqueDead": 0.01}, 
						"pasque3Dying": {"pasque3": 0.5,                       "pasqueDead": 0.01}, 
						"pasque4Dying": {"pasque4": 0.5,                       "pasqueDead": 0.01}, 
						  "pasqueDead": {}},
						Species.WildYam: {
						 "wildYamBlank": {}, 
							 "wildYam0": {"wildYam1": 0.28,                        "wildYamDead": 0.01}, 
							 "wildYam1": {"wildYam2": 0.2, "wildYam1Dying": 0.13, "wildYamDead": 0.01}, 
							 "wildYam2": {"wildYam3": 0.11, "wildYam2Dying": 0.08, "wildYamDead": 0.01}, 
							 "wildYam3": {"wildYam4": 0.03, "wildYam3Dying": 0.02, "wildYamDead": 0.01}, 
							 "wildYam4": {                 "wildYam4Dying": 0.1, "wildYamDead": 0.01}, 
						"wildYam1Dying": {"wildYam1": 0.5,                        "wildYamDead": 0.01}, 
						"wildYam2Dying": {"wildYam2": 0.5,                        "wildYamDead": 0.01}, 
						"wildYam3Dying": {"wildYam3": 0.5,                        "wildYamDead": 0.01}, 
						"wildYam4Dying": {"wildYam4": 0.5,                        "wildYamDead": 0.01}, 
						  "wildYamDead": {}}
						}

# Called when the node enters the scene tree for the first time.
func _ready():
	for species in stateMachineData: 
		for stateName in stateMachineData[species]:
			var state = plantStateClass.new()
			state.species = species
			state.path = speciesPaths[species] + stateName + ".svg"
			possiblePlantStates[stateName] = state
	
	for species in stateMachineData:
		for stateName in stateMachineData[species]:
			for nextStateName in stateMachineData[species][stateName]:
				var state = possiblePlantStates[stateName]
				var nextState = possiblePlantStates[nextStateName]
				state.add_next_state(nextState, stateMachineData[species][stateName][nextStateName])
	ladySlipperInitialState = possiblePlantStates["ladySlipperBlank"]
	pasqueInitialState = possiblePlantStates["pasqueBlank"]
	wildYamInitialState = possiblePlantStates["wildYamBlank"]

func _process(_delta):
	pass
