extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$potSoil._ready()
	$rack._ready()
	$plant._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
