extends Area2D

# https://www.youtube.com/watch?v=drt5wUr3AWY

@export var tilemap_path : NodePath
@export var swing_time : float = 0.25

var is_swinging = false

var tilemap : TileMap

@onready var swing_timer = $SwingTimer
@onready var animation_player = $AnimationPlayer

func _ready():
	tilemap = get_node(tilemap_path)

func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("mb_left"):
		start_swing()
	if Input.is_action_just_pressed("mb_right"):
		stop_swing()

func start_swing():
	print("Started")
	is_swinging = true
	swing_timer.start(swing_time)
	animation_player.play("swing")
	#animation_player.set_speed(1 / swing_time)

func stop_swing():
	print("Stopped")
	is_swinging = false
	swing_timer.stop()
	animation_player.stop()


func _on_swing_timer_timeout():
	hit_block()
	if is_swinging: # Making it loop
		swing_timer.start(swing_time)
		animation_player.play("swing")

func hit_block():
	var tile : Vector2 = tilemap.local_to_map($CollisionShape2D.global_position)
	var id = tilemap.get_cell_atlas_coords(0, tile)
	var source_id = tilemap.get_cell_source_id(0, tile)
	if source_id == -1: return
	var new_id = 1
	if id.x < 5:
		new_id = id.x + 1
		tilemap.set_cell(0, tile, 0, Vector2(new_id, 1))
