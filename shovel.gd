extends Area2D

var isPlaying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if (!get_parent().get_node("potSoil").is_overfull()):
			isPlaying = true
			$AnimationPlayer.play("fill_soil")

func _input(event: InputEvent):
	if isPlaying and event is InputEventMouseButton:
		get_viewport().set_input_as_handled()


func _on_animation_player_animation_finished(_anim_name):
	isPlaying = false
