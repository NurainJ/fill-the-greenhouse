extends Node2D

var isDraggingShovel = false
var isMouseInsideSoil = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$potSoil._ready()
	$rack._ready()
	$plant._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_soil_bag_soil_mouse_entered():
	isMouseInsideSoil = true


func _on_soil_bag_soil_mouse_exited():
	isMouseInsideSoil = false


func _on_shovel_mouse_entered():
	if !isDraggingShovel:
		$shovel.scale = Vector2(1.05, 1.05)


func _on_shovel_mouse_exited():
	if !isDraggingShovel:
		$shovel.scale = Vector2(1, 1)
