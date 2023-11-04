extends CanvasLayer

func _process(_delta):
	if $PlayerStats/VBoxContainer2/StaminaBar.value < 25:
		$PlayerStats/VBoxContainer2/StaminaBar.self_modulate = Color( 0.82, 0.392, 0)
	else: 
		$PlayerStats/VBoxContainer2/StaminaBar.self_modulate = Color(0, 0.592, 0.35)

func set_pistol_ammo_text(amount: int):
	%"Pistol Ammo Amount Text".text = str(amount)

func set_shotgun_ammo_text(amount: int):
	%"Shotgun Ammo Amount Text".text = str(amount)

func set_song_text(text: String):
	$HBoxContainer/SongTextLabel.text = text

func update_health_value(new_value: int):
	$PlayerStats/VBoxContainer2/HealthBar.value = new_value

func update_stamina_value(new_value: float):
	$PlayerStats/VBoxContainer2/StaminaBar.value = new_value

func show_weapon_stats():
	$PlayerStats/VBoxContainer.visible = true
