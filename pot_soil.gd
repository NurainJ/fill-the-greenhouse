extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	set_texture(load(GameVariables.soilPaths[GameVariables.activePlant]))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func is_overfull():
	return GameVariables.soilPaths[GameVariables.activePlant] == GameVariables.possibleSoilPaths[GameVariables.possibleSoilPaths.size() - 1]

func update_state():
	if !is_overfull():
		var soilPathIndex = GameVariables.possibleSoilPaths.find(GameVariables.soilPaths[GameVariables.activePlant])
		GameVariables.soilPaths[GameVariables.activePlant] = GameVariables.possibleSoilPaths[soilPathIndex + 1]
		set_texture(load(GameVariables.soilPaths[GameVariables.activePlant]))
