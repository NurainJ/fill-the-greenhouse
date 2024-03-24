extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	set_texture(load(GameVariables.Base + GameVariables.plantProperties[GameVariables.activePlant][GameVariables.Properties.currentState]))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
