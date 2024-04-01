extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func fade_to_black():
	visible = true
	$BlackScreenPlayer.play("fade_to_black")
	

func _input(event: InputEvent):
	if is_visible() and event is InputEventMouseButton:
		get_viewport().set_input_as_handled()


func _on_animation_player_animation_finished(_anim_name):
	visible = false