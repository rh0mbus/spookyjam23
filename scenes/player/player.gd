extends CharacterBody2D

var speed: float = 20.0 #35 when running

const FRICTION: float = 4.0
const ACCELERATION: float = 2.0
const JUMP_VELOCITY: float = -80.0
const AIM_SPEED: float = 1.0
var recoil_amount: float = 50

var is_weapon_equipped : bool = false
var is_able_to_change_rooms: bool = false
var target_room_location: Vector2

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$ReticleSprite.visible = false

func _process(_delta):
	
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
		
	if Input.is_action_just_pressed("select_weapon_1"):
		print("pressed 1")
		is_weapon_equipped = !is_weapon_equipped
		print(is_weapon_equipped)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if is_weapon_equipped:
		$ReticleSprite.visible = true
		if Input.is_action_just_pressed("fire"):
			var current_rotation = $ReticleSprite.global_rotation_degrees
			if current_rotation >= -90 and current_rotation <= 90:
				velocity.x += -recoil_amount
			else:
				velocity.x += recoil_amount
	else:
		$ReticleSprite.visible = false

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, speed * direction, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)

	move_and_slide()


func set_room_target(location: Vector2):
	enable_interact_ui()
	is_able_to_change_rooms = true
	target_room_location = location

func change_rooms():
	TransitionLayer.change_rooms()
	$DoorTimer.start()
	await $DoorTimer.timeout
	global_position = target_room_location
	
func enable_interact_ui():
	$UI.enable_interact_text()

func disable_interact_ui():
	is_able_to_change_rooms = false
	$UI.disable_interact_text()
