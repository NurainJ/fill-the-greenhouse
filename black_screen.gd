extends Sprite2D

func fade_to_black():
	visible = true
	$BlackScreenPlayer.play("fade_to_black")


# When the black screen is showing, no other clicking is allowed
func _input(_event: InputEvent):
	if is_visible():
		get_viewport().set_input_as_handled()


func _on_animation_player_animation_finished(_anim_name):
	visible = false
