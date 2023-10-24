extends CharacterBody2D

var speed: float = 20.0 #30 when running

const FRICTION: float = 4.0
const JUMP_VELOCITY: float = -80.0
const AIM_SPEED: float = 1.0
var recoil_amount: float = 50

var is_weapon_equipped : bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$ReticleSprite.visible = false

func _process(_delta):
	
	if Input.is_action_pressed("sprint"):
		speed = 30.0
		print("sprinting...")
		
	if Input.is_action_just_released("sprint"):
		speed = 20.0
		
	if Input.is_action_just_pressed("select_weapon_1"):
		print("pressed 1")
		is_weapon_equipped = !is_weapon_equipped
		print(is_weapon_equipped)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump
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

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)

	move_and_slide()


func change_rooms(location: Vector2):
	
	TransitionLayer.in_out()
	global_position = location
