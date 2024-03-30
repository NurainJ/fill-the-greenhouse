extends Object

var species : GameVariables.Species
var path : String
var nextStates = {}

func add_next_state(newNextState, nextStateProbability: float):
	nextStates[newNextState] = nextStateProbability

func remove_next_state(state): 
	nextStates.erase(state)

func get_next_state():
	for state in nextStates:
		if randf() < nextStates.get(state):
			return state
	return self
