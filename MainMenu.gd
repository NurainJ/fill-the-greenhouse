class_name MainMenu
extends Control


#@onready var play = $MarginContainer/HBoxContainer/VBoxContainer/Play as Button
@onready var settings = $MarginContainer/HBoxContainer/VBoxContainer/Settings as Button
@onready var exit = $MarginContainer/HBoxContainer/VBoxContainer/Exit as Button
@onready var settings_menu = $SettingsMenu as SettingsMenu
@onready var margin_container = $MarginContainer as MarginContainer

#@onready var start_game = preload("res://main_screen.tscn") as PackedScene


func _ready():
	handle_connecting_signals()
	
#func on_start_pressed() -> void:
	#get_tree().change_scene_to_packed(start_game)

func on_settings_pressed() -> void:
	margin_container.visible = false
	settings_menu.set_process(true)
	settings_menu.visible = true


func on_exit_pressed() -> void:
	get_tree().quit()


func on_exit_settings_menu() -> void:
	margin_container.visible = true
	settings_menu.visible = (false)


func handle_connecting_signals() -> void:
	#play.button_down.connect(on_start_pressed)
	settings.button_down.connect(on_settings_pressed)
	exit.button_down.connect(on_exit_pressed)
	settings_menu.exit_settings_menu.connect(on_exit_settings_menu)
