extends Area2D

var isPlaying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func add_soil():
	isPlaying = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(650, 175), 0.1)
	$AnimationPlayer.play("fill_soil")
	await $AnimationPlayer.animation_finished
	get_parent().isAnimating = false

func remove_soil():
	isPlaying = true
	var tween = get_tree().create_tween()
	print("rotation")
	tween.tween_property(self, "position", Vector2(1295, 473), 0.1)
	tween.tween_property(self, "rotation", deg_to_rad(-34), 0.1)
	await tween.finished
	$AnimationPlayer.play("remove_soil")
	await $AnimationPlayer.animation_finished
	get_parent().isAnimating = false
	
func _input(event: InputEvent):
	if isPlaying and event is InputEventMouseButton:
		get_viewport().set_input_as_handled()


func _on_animation_player_animation_finished(_anim_name):
	isPlaying = false
