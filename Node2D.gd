extends Node2D

var bat: PackedScene = preload("res://scenes/monsters/bat.tscn")

var is_bat_spawnable: bool = true

func _ready():
	TransitionLayer.hide()

func _process(delta):
	if is_bat_spawnable:
		spawn_bat()
		is_bat_spawnable = false

func spawn_bat():	
	var time = randi_range(1, 3)
	await get_tree().create_timer(time).timeout

	var new_bat = bat.instantiate() as Node2D
	$SpawnMarker.add_child(new_bat)
	new_bat.position = $SpawnMarker.position
	new_bat.direction = Vector2.RIGHT
	print(new_bat.position)
	print(new_bat.visible)
	is_bat_spawnable = true
