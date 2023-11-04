extends Node2D

@export var sound_clip : AudioStream 	

const MAX_AMMO_COUNT: int = 2
const MAX_ZOMBIE_COUNT: int = 5

var bat: PackedScene = preload("res://scenes/monsters/bat.tscn")
var ghost: PackedScene = preload("res://scenes/monsters/ghost.tscn")
var ghoul: PackedScene = preload("res://scenes/monsters/ghoul.tscn")
var ammo_box: PackedScene = preload("res://scenes/items/ammo_pickup.tscn")
var medkit: PackedScene = preload("res://scenes/items/health_pickup.tscn")
var zombie: PackedScene = preload("res://scenes/monsters/zombie.tscn")

var is_bat_spawnable: bool = true
var is_ghost_spawnable: bool = true
var is_ghoul_spawnable: bool = true
var is_zombie_spawnable: bool = true
var zombie_count: int = 0

var is_medkit_spawnable: bool = true
var is_ammo_spawnable: bool = true
var medkit_count: int  = 0
var ammo_box_count: int = 0

@onready var song_0: AudioStreamMP3 = load("res://resources/audio/Black Cat  Halloween Autumn Lofi.mp3")
@onready var song_1: AudioStreamMP3 = load("res://resources/audio/Cinnamon Specters  - Panda Beats.mp3") 
@onready var song_2: AudioStreamMP3 = load("res://resources/audio/Cursed Spells  - Panda Beats.mp3") 
@onready var song_3: AudioStreamMP3 = load("res://resources/audio/Mystical Maple  - Panda Beats.mp3") 
@onready var song_4: AudioStreamMP3 = load("res://resources/audio/Ominous Owls  - Panda Beats.mp3") 
@onready var song_5: AudioStreamMP3 = load("res://resources/audio/Panda Beats - Beautiful Monsters.mp3") 
@onready var song_6: AudioStreamMP3 = load("res://resources/audio/Spooky Hallway Clock  - Panda Beats.mp3") 
@onready var song_7: AudioStreamMP3 = load("res://resources/audio/Witching Hours  - Panda Beats.mp3") 
@onready var song_8: AudioStreamMP3 = load("res://resources/audio/Lofi Astronaut - Ghost Town.mp3") 
@onready var song_9: AudioStreamMP3 = load("res://resources/audio/Lofi Astronaut - Haunted House.mp3") 
@onready var song_10: AudioStreamMP3 = load("res://resources/audio/Lofi Astronaut - Paranormal.mp3") 
@onready var song_11: AudioStreamMP3 = load("res://resources/audio/Lofi Astronaut - Shadows.mp3") 
 
var song_array = []

# Called when the node enters the scene tree for the first time.
func _ready():

	init_song_list()
	$Audio/BGM_Music.stream = song_array.pick_random()
	$Audio/BGM_Music.play()
	$Player.change_song_on_hud($Audio/BGM_Music.stream.resource_name)

	for door in get_tree().get_nodes_in_group("door_entry"):
		door.connect('player_entered_door_area', _player_entered_openable_area)
		door.connect('player_left_door_area', _player_left_area)
	
	var tween = create_tween()
	tween.tween_property($Audio/BGM_Music, "volume_db", -20, 10)
	TransitionLayer.fade_in()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	if ammo_box_count >= MAX_AMMO_COUNT:
		is_ammo_spawnable = false
	else:
		is_ammo_spawnable = true
	
	if medkit_count > 0:
		is_medkit_spawnable = false
	else:
		is_medkit_spawnable = true
		
	if zombie_count >= MAX_ZOMBIE_COUNT: 
		is_zombie_spawnable = false
	else:
		is_zombie_spawnable = true

	if is_bat_spawnable:
		spawn_bat()
		is_bat_spawnable = false

	if is_ghost_spawnable:
		spawn_ghost()
		is_ghost_spawnable = false

	if is_ghoul_spawnable:
		spawn_ghoul()
		is_ghoul_spawnable = false
	
	if is_zombie_spawnable:
		spawn_zombie()
		is_zombie_spawnable = false
		zombie_count += 1
		
	if is_ammo_spawnable:
		ammo_box_count += 1
		spawn_ammo()
		
	if is_medkit_spawnable:
		medkit_count += 1
		spawn_medkit()

	if Input.is_action_just_pressed("change_song"):
		$Audio/BGM_Music.stop()
		$Audio/BGM_Music.stream = song_array.pick_random()
		$Player.change_song_on_hud($Audio/BGM_Music.stream.resource_name)
		$Audio/BGM_Music.play()

func _player_entered_openable_area(target_pos):
	$Player.set_room_target(target_pos)
	
func _player_left_area():
	$Player.disable_interact_ui()

func init_song_list():
	song_0.resource_name = "Black Cat - Panda Beats"
	song_1.resource_name = "Cinnamon Specters - Panda Beats"
	song_2.resource_name = "Cursed Spells - Panda Beats"
	song_3.resource_name = "Mystical Maple- Panda Beats"
	song_4.resource_name = "Ominous Owls - Panda Beats"
	song_5.resource_name = "Beautiful Monsters - Panda Beats"
	song_6.resource_name = "Spooky Hallway Clock - Panda Beats"
	song_7.resource_name = "Witching Hours - Panda Beats"
	song_8.resource_name = "Ghost Town - Lofi Astronaut"
	song_9.resource_name = "Haunted House - Lofi Astronaut"
	song_10.resource_name = "Paranormal - Lofi Astronaut"
	song_11.resource_name = "Shadows - Lofi Astronaut"
	song_array.append(song_0)
	song_array.append(song_1)
	song_array.append(song_2)
	song_array.append(song_3)
	song_array.append(song_4)
	song_array.append(song_5)
	song_array.append(song_6)
	song_array.append(song_7)
	song_array.append(song_8)
	song_array.append(song_9)
	song_array.append(song_10)
	song_array.append(song_11)

func spawn_bat():	
	var time = randi_range(15, 60)
	await get_tree().create_timer(time).timeout

	var new_bat = bat.instantiate() as Node2D
	$BatSpawnMarker.add_child(new_bat)
	new_bat.global_position = $BatSpawnMarker.global_position
	new_bat.direction = Vector2.RIGHT
	is_bat_spawnable = true

func spawn_ghost():
	var time = randi_range(60, 120)
	await get_tree().create_timer(time).timeout

	var new_ghost = ghost.instantiate() as Node2D
	$GhostSpawnMarker.add_child(new_ghost)
	new_ghost.global_position = $GhostSpawnMarker.global_position
	new_ghost.direction = Vector2.RIGHT
	is_ghost_spawnable = true

func spawn_ghoul():
	var time = randi_range(60, 120)
	await get_tree().create_timer(time).timeout
	
	var new_ghoul = ghoul.instantiate() as Node2D
	$GhoulSpawnMarker.add_child(new_ghoul)
	new_ghoul.global_position = $GhoulSpawnMarker.global_position
	is_ghoul_spawnable = true

func spawn_zombie():
	var time = randi_range(15, 60)
	await get_tree().create_timer(time).timeout
	
	var new_zombie = zombie.instantiate() as CharacterBody2D
	var new_parent = get_tree().get_nodes_in_group("ZombieSpawn").pick_random()
	new_parent.add_child(new_zombie)
	new_zombie.global_position = new_parent.global_position
	new_zombie.scale = Vector2(0.72, 0.72)

func spawn_ammo():
	var time = randi_range(30, 60)
	await get_tree().create_timer(time).timeout
	
	var new_box = ammo_box.instantiate() as Area2D
	var new_parent = get_tree().get_nodes_in_group("AmmoSpawn").pick_random()
	new_parent.add_child(new_box)
	new_box.global_position = new_parent.global_position
	var random_offset = randi_range(-10, 10)
	new_box.global_position.x += random_offset
	new_box.connect('ammo_picked_up', _on_player_picked_up_ammo)
	
func spawn_medkit():
	var time = randi_range(30, 60)
	await get_tree().create_timer(time).timeout
	
	var new_med = medkit.instantiate() as Area2D
	var new_parent = get_tree().get_nodes_in_group("MedSpawn").pick_random()
	new_parent.add_child(new_med)
	new_med.global_position = new_parent.global_position
	var random_offset = randi_range(-5, 5)
	new_med.global_position.x += random_offset
	new_med.connect('health_picked_up', _on_health_pickup_health_picked_up)
	
func _on_bgm_music_finished():
	$Audio/BGM_Music.stop()
	$Audio/BGM_Music.stream = song_array.pick_random()
	$Player.change_song_on_hud($Audio/BGM_Music.stream.resource_name)
	$Audio/BGM_Music.play()

func _on_player_picked_up_ammo(amount: int):
	ammo_box_count -= 1
	$Player.add_ammo(amount)

func _on_weapon_safe_player_opened_safe():
	$Player.give_weapons()

func _on_damage_area_damage(damage):
	$Player.mutate_health(damage)

func _on_health_pickup_health_picked_up(amount):
	medkit_count -= 1
	$Player.mutate_health(amount)
