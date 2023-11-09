extends Node2D

var intro_scene: PackedScene = preload("res://scenes/intro_movie.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	TransitionLayer.fade_in()

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(intro_scene)

func _on_quit_button_pressed():
	get_tree().quit()
