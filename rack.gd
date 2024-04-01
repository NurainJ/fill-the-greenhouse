extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var currentSpecies = GameVariables.plantStates[GameVariables.activePlant].species
	if currentSpecies == GameVariables.Species.Pasque:
		$pasquePacket.visible = true
	elif currentSpecies == GameVariables.Species.WildYam:
		$wildYamPacket.visible = true
	else:
		$ladySlipperPacket.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		SceneSwitcher.set_scene("res://rack.tscn")
		queue_free()
