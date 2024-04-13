extends Node2D
const PotResouce = preload("res://pot.tscn")

const PotPosition = [
	Vector2(-826, 154), 
	Vector2(-602, 67), 
	Vector2(-273, -4), 
	Vector2(3, -3), 
	Vector2(260, -6), 
	Vector2(595, 65), 
	Vector2(814, 154)]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(7):
		var pot = PotResouce.instantiate()
		pot.name = "Pot" + str(x + 1)
		pot.position = PotPosition[x]
		pot.number = x
		
		GameVariables.soilPaths.append(GameVariables.possibleSoilPaths[0])
		GameVariables.plantStates.append(GameVariables.ladySlipperInitialState)
		
		self.add_child(pot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	$BlackScreen.fade_to_black()
