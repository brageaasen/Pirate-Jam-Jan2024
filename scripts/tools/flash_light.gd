extends "res://scripts/tools/tool.gd"

func look_at_mouse():
	var mouse_position = get_global_mouse_position()
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
		pass
	if Input.is_action_just_pressed("mb_right"):
		pass
	
	look_at_mouse()


@onready var point_light_2d_2 = $PointLight2D2

func equip():
	equipped = true
	sprite.visible = true
	point_light_2d_2.enabled = true

func un_equip():
	equipped = false
	sprite.visible = false
	point_light_2d_2.enabled = false


func _on_body_entered(body):
	if body.is_in_group("tree"):
		pass

func _on_body_exited(body):
	if body.is_in_group("tree"):
		pass
