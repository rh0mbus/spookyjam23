extends Node2D

@export var sound_clip : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property($BGM_Music, "volume_db", -20, 10)
	TransitionLayer.fade_in()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


func _on_kitchen_door_player_entered_door_area(target_pos):
	$MainInteriorBackLayer/Player.set_room_target(target_pos)
