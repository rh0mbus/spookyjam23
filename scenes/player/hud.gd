extends CanvasLayer
	
func set_pistol_ammo_text(amount: int):
	%"Pistol Ammo Amount Text".text = str(amount)

func set_shotgun_ammo_text(amount: int):
	%"Shotgun Ammo Amount Text".text = str(amount)

func set_song_text(text: String):
	$HBoxContainer/SongTextLabel.text = text
