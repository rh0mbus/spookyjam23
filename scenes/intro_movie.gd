extends Node2D

var main_scene: PackedScene = preload("res://scenes/main_level.tscn")

func _ready():
	TransitionLayer.fade_in()
	var tween = create_tween()
	tween.tween_property($BGM, "volume_db", -10, 10)

func transition_out():
	TransitionLayer.fade_out()

func load_main_scene():
	get_tree().change_scene_to_packed(main_scene)
