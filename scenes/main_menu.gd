extends Node2D

var main_scene: PackedScene = preload("res://scenes/main_level.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	TransitionLayer.fade_in()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(main_scene)

func _on_quit_button_pressed():
	get_tree().quit()
