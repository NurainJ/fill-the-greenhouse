extends Node

#Code source: https://forum.godotengine.org/t/how-to-detect-swipe-using-3-0/29338/4
signal swipeRight
signal swipeLeft
var swipe_start = null
var minimum_drag = 100
var swipe = false

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		swipe_start = get_viewport().get_mouse_position()
	if event is InputEventMouseButton and !event.pressed:
		_calculate_swipe(get_viewport().get_mouse_position())
		
func _calculate_swipe(swipe_end):
	swipe = false
	if swipe_start == null: 
		return
	var swipeDistance = swipe_end - swipe_start
	if abs(swipeDistance.x) > minimum_drag:
		swipe = true
		if swipeDistance.x > 0:
			emit_signal("swipeRight")
		else:
			emit_signal("swipeLeft")
