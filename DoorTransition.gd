extends Area2D

@export var partner: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_open_door_text():
	pass


func _on_body_entered(body):
	if "change_rooms" in body:
		print("its the player")
