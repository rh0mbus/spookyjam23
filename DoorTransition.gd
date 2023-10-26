extends Area2D

signal player_entered_door_area(target_pos)
signal player_left_door_area

@export var partner: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func show_open_door_text():
	pass


func _on_body_entered(body):
	if "change_rooms" in body:
		player_entered_door_area.emit(partner.global_position)


func _on_body_exited(body):
	if "change_rooms" in body:
		player_left_door_area.emit()
