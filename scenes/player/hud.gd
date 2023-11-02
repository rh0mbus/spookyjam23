extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_pistol_ammo_text(amount: int):
	%"Pistol Ammo Amount Text".text = str(amount)

func set_shotgun_ammo_text(amount: int):
	%"Shotgun Ammo Amount Text".text = str(amount)
