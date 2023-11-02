extends CharacterBody2D

var speed: float = 20.0 #35 when running

const FRICTION: float = 4.0
const ACCELERATION: float = 2.0
const JUMP_VELOCITY: float = -80.0
const AIM_SPEED: float = 1.0

var recoil_amount: float = 50
var reload_time: float = 1
var is_weapon_equipped : bool = false
var is_pistol_equipped: bool = true
var is_able_to_shoot: bool = true
var is_able_to_change_rooms: bool = false
var target_room_location: Vector2

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_player_armed: bool = false
var pistol_ammo: int = 18
var shotgun_ammo: int = 6

func _ready():
	$ReticleSprite.visible = false

func _process(_delta):
	
	var current_rotation = $ReticleSprite.global_rotation_degrees
	
	if current_rotation >= -90 and current_rotation <= 90:
		$ReticleSprite/Pistol.flip_h = false
		$ReticleSprite/Pistol.flip_v = false
		$ReticleSprite/Shotgun.flip_h = true
		$ReticleSprite/Shotgun.flip_v = false
	else:
		$ReticleSprite/Pistol.flip_h = false
		$ReticleSprite/Pistol.flip_v = true
		$ReticleSprite/Shotgun.flip_h = true
		$ReticleSprite/Shotgun.flip_v = true
	
	if is_able_to_change_rooms:
		$UI.show()
		if Input.is_action_just_pressed("interact"):
			change_rooms()
	else:
		$UI.hide()
	
	if Input.is_action_pressed("sprint"):
		speed = 35.0
		
	if Input.is_action_just_released("sprint"):
		speed = 20.0
	
	if is_player_armed and Input.is_action_just_pressed("select_weapon_1"):
		is_weapon_equipped = true
		is_pistol_equipped = true
		recoil_amount = 20
		reload_time = 0.2
		$ReticleSprite/Pistol.equip()
		$ReticleSprite/Shotgun.unequip()
	
	if is_player_armed and Input.is_action_just_pressed("select_weapon_2"):
		is_weapon_equipped = true
		recoil_amount = 50
		is_pistol_equipped = false
		reload_time = 0.55
		$ReticleSprite/Pistol.unequip()
		$ReticleSprite/Shotgun.equip()
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if is_weapon_equipped:
		$ReticleSprite.visible = true
		if Input.is_action_just_pressed("fire") and is_able_to_shoot:
			is_able_to_shoot = false

			var current_rotation = $ReticleSprite.global_rotation_degrees

			if is_pistol_equipped and pistol_ammo >= 1:
				$ReticleSprite/Pistol.fire()
				pistol_ammo -= 1
				$HUD.set_pistol_ammo_text(pistol_ammo)
				do_recoil(current_rotation)
			elif not is_pistol_equipped and shotgun_ammo >= 1:
				$ReticleSprite/Shotgun.fire()
				shotgun_ammo -= 1
				$HUD.set_shotgun_ammo_text(shotgun_ammo)
				do_recoil(current_rotation)
			else:
				pass

			await get_tree().create_timer(reload_time).timeout
			is_able_to_shoot = true
	else:
		$ReticleSprite.visible = false

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, speed * direction, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)

	move_and_slide()

func do_recoil(rot: float):
	if rot >= -90 and rot <= 90:
		velocity.x += -recoil_amount
	else:
		velocity.x += recoil_amount

func set_room_target(location: Vector2):
	enable_interact_ui()
	is_able_to_change_rooms = true
	target_room_location = location

func change_rooms():
	TransitionLayer.change_rooms()
	$DoorTimer.start()
	$DoorSFXPlayer.play()
	await $DoorTimer.timeout
	global_position = target_room_location
	
func enable_interact_ui():
	$UI.enable_interact_text()

func disable_interact_ui():
	is_able_to_change_rooms = false
	$UI.disable_interact_text()

func give_weapons():
	is_player_armed = true
	$HUD.visible = true

func _on_door_timer_timeout():
	pass # Replace with function body.

func add_ammo(amount: int):
	if amount == 15:
		pistol_ammo += amount
		$HUD.set_pistol_ammo_text(pistol_ammo)
	else:
		shotgun_ammo += amount
		$HUD.set_shotgun_ammo_text(shotgun_ammo)
