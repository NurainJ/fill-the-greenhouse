extends Node

var temperature = 75
var days_remaining = 40
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
							 "ladySlipper0": {"ladySlipper1": 0.45,                            "ladySlipperDead": 0.01}, 
							 "ladySlipper1": {"ladySlipper2": 0.3, "ladySlipper1Dying": 0.0126, "ladySlipperDead": 0.001}, 
							 "ladySlipper2": {"ladySlipper3": 0.15, "ladySlipper2Dying": 0.009, "ladySlipperDead": 0.001}, 
							 "ladySlipper3": {"ladySlipper4": 0.05, "ladySlipper3Dying": 0.0045, "ladySlipperDead": 0.001}, 
							 "ladySlipper4": {                     "ladySlipper4Dying": 0.1, "ladySlipperDead": 0.001}, 
						"ladySlipper1Dying": {"ladySlipper1": 0.0126,                            "ladySlipperDead": 0.0252}, 
						"ladySlipper2Dying": {"ladySlipper2": 0.09,                            "ladySlipperDead": 0.018}, 
						"ladySlipper3Dying": {"ladySlipper3": 0.0045,                            "ladySlipperDead": 0.009}, 
						"ladySlipper4Dying": {"ladySlipper4": 0.002,                            "ladySlipperDead": 0.0045}, 
						  "ladySlipperDead": {}}, 
						Species.Pasque: {
						 "pasqueBlank": {},
							 "pasque0": {"pasque1": 0.46,                       "pasqueDead": 0.001}, 
							 "pasque1": {"pasque2": 0.35, "pasque1Dying": 0.0084, "pasqueDead": 0.001}, 
							 "pasque2": {"pasque3": 0.18, "pasque2Dying": 0.006, "pasqueDead": 0.001}, 
							 "pasque3": {"pasque4": 0.06, "pasque3Dying": 0.0033, "pasqueDead": 0.001}, 
							 "pasque4": {                "pasque4Dying": 0.002, "pasqueDead": 0.001}, 
						"pasque1Dying": {"pasque1": 0.0084,                       "pasqueDead": 0.0168}, 
						"pasque2Dying": {"pasque2": 0.006,                       "pasqueDead": 0.012}, 
						"pasque3Dying": {"pasque3": 0.0033,                       "pasqueDead": 0.0066}, 
						"pasque4Dying": {"pasque4": 0.002,                       "pasqueDead": 0.0033}, 
						  "pasqueDead": {}},
						Species.WildYam: {
						 "wildYamBlank": {}, 
							 "wildYam0": {"wildYam1": 0.28,                        "wildYamDead": 0.001}, 
							 "wildYam1": {"wildYam2": 0.2, "wildYam1Dying": 0.0138, "wildYamDead": 0.001}, 
							 "wildYam2": {"wildYam3": 0.11, "wildYam2Dying": 0.0105, "wildYamDead": 0.001}, 
							 "wildYam3": {"wildYam4": 0.03, "wildYam3Dying": 0.0054, "wildYamDead": 0.001}, 
							 "wildYam4": {                 "wildYam4Dying": 0.0075, "wildYamDead": 0.001}, 
						"wildYam1Dying": {"wildYam1": 0.0138,                        "wildYamDead": 0.0276}, 
						"wildYam2Dying": {"wildYam2": 0.0105,                        "wildYamDead": 0.021}, 
						"wildYam3Dying": {"wildYam3": 0.0054,                        "wildYamDead": 0.0108}, 
						"wildYam4Dying": {"wildYam4": 0.0075,                        "wildYamDead": 0.015}, 
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
