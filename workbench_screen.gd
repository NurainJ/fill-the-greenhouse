extends Node2D

var isDraggingShovel = false
var isShovelInsideSoil = false
var isMouseInsideShovel = false
var isAnimating = false
var initialShovelPosition = Vector2(1600, 870)
var offset: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	$potSoil._ready()
	$rack._ready()
	$plant._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isMouseInsideShovel and !isAnimating:
		if !isShovelInsideSoil:
			if Input.is_action_just_pressed("click"):
				offset = get_global_mouse_position() - $shovel.global_position
				isDraggingShovel = true
			if Input.is_action_pressed("click"):
				$shovel.global_position = get_global_mouse_position() - offset
			elif Input.is_action_just_released("click"):
				isDraggingShovel = false
				var tween = get_tree().create_tween()
				tween.tween_property($shovel, "position", initialShovelPosition, 1)
		else:
			print("adding soil")
			isAnimating = true
			isShovelInsideSoil = false
			await $shovel.add_soil()

func _on_soil_bag_area_entered(area):
	if !isAnimating and area == $shovel:
		isShovelInsideSoil = true

func _on_soil_bag_area_exited(area):
	if area == get_node("shovel/CollisionPolygon2D"):
		isShovelInsideSoil = false


func _on_shovel_mouse_entered():
	isMouseInsideShovel = true
	if !isDraggingShovel:
		$shovel.scale = Vector2(1.05, 1.05)


func _on_shovel_mouse_exited():
	if !isDraggingShovel:
		isMouseInsideShovel = false
		$shovel.scale = Vector2(1, 1)




