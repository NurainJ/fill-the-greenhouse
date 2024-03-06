extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	update_display()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_display():
	$CalendarText.set_text(str(GameVariables.days_remaining))
