extends "res://scripts/tools/tool.gd"

@export var tree_damage : float = 10.0

var can_saw = false
@onready var saw_particles = $CollisionShape2D/SawParticles

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
	#print(z_index)
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
	saw_particles.emitting = false
	is_swinging = false
	swing_timer.stop()
	animation_player.stop()


func _on_swing_timer_timeout():
	hit_tree()
	if is_swinging: # Making it loop
		swing_timer.start(swing_time)
		animation_player.play("swing")

func hit_tree():
	if can_saw:
		saw_particles.emitting = true
		z_index = 1
	else:
		saw_particles.emitting = false


func _on_body_entered(body):
	if body.is_in_group("tree"):
		can_saw = true

func _on_body_exited(body):
	if body.is_in_group("tree"):
		print("exit")
		z_index = 0
		can_saw = false
