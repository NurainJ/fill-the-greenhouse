#extends Area2D
#
#var move_speed = 150
#var initial_position = Vector2()
#var fade_speed = 0.5
#
#func _ready():
	#initial_position = position
#
#func _process(delta):
	#position.x += -move_speed * delta
	#modulate.a -= fade_speed * delta
	#if modulate.a <= 0 or abs(position.x - initial_position.x) > 200:
		#position = initial_position
		#modulate.a = 1
	#modulate.a = max(modulate.a, 0)
