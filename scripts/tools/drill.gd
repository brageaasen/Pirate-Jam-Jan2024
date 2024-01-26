extends "res://scripts/tools/tool.gd"

var tilemap : TileMap

var audio_manager : AudioManager

@export var recource_drop : PackedScene

signal spawn_loot

func _ready():
	tilemap = get_parent().get_parent().get_parent().get_node("TileMap")
	audio_manager = get_node("/root/Game/AudioManager")

func look_at_mouse():
	var mouse_position = get_global_mouse_position()
	
	if player.direction != Vector2.ZERO: # TODO: and tool is not equipped
		var target_position = player.position
		if player.direction.x < 0:  # Player is moving left
			position.x = -abs(position.x)
			target_position.x -= 200  # Look to the left
		elif player.direction.x > 0:  # Player is moving right
			position.x = abs(position.x)
			target_position.x += 200  # Look to the right
		look_at(target_position)
		return
	look_at(mouse_position)
	
	var flip_threshold = 5 # Pixels threshold to avoid jittering
	var sprite_center_x = global_position.x
	var mouse_distance_from_center = abs(mouse_position.x - sprite_center_x)

	# Only flip if the mouse is beyond the threshold
	if mouse_distance_from_center > flip_threshold:
		var left_of_sprite = mouse_position.x < sprite_center_x
		var right_of_sprite = mouse_position.x > sprite_center_x

		# Flip the sprite if necessary
		if (left_of_sprite and not body.flip_h) or (right_of_sprite and body.flip_h):
			body.flip_h = not body.flip_h
			flip()

func flip():
	position.x *= -1

func _physics_process(delta):
	if not equipped:
		return
	
	if Input.is_action_just_pressed("mb_left"):
		start_swing()
	if Input.is_action_just_pressed("mb_right"):
		stop_swing()
	
	look_at_mouse()


func start_swing():
	is_swinging = true
	swing_timer.start(swing_time)
	animation_player.play("swing")
	#animation_player.set_speed(1 / swing_time)

func stop_swing():
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
		audio_manager.play_random_sound(audio_manager.player_hit_ground_sounds)
		new_id = id.x + 1
		tilemap.set_cell(0, tile, 0, Vector2(new_id, id.y))
		if id.x == 4 and id.y == 1: # Broken recource tile
			emit_signal("spawn_loot", recource_drop, null, tilemap.map_to_local(tile))
