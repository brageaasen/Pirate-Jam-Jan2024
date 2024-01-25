extends "res://scripts/tools/tool.gd"

@export var light_damage : int = 5

var inside_light = []

@onready var light = $Light

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
		for enemy in inside_light:
			if enemy.has_method("stop_burn"):
				enemy.stop_burn()
		return
	for enemy in inside_light:
		if enemy.has_method("burn") and enemy.is_burning:
			enemy.burn(light_damage)
	
	if Input.is_action_just_pressed("mb_left"):
		pass
	if Input.is_action_just_pressed("mb_right"):
		pass
	
	look_at_mouse()



func equip():
	equipped = true
	sprite.visible = true
	light.enabled = true

func un_equip():
	equipped = false
	sprite.visible = false
	light.enabled = false


func _on_light_body_entered(body):
	if body.is_in_group("enemy") and light.enabled:
		inside_light.append(body)
		if body.has_method("burn") and !body.is_burning:
			body.burn(light_damage)


func _on_light_body_exited(body):
	if body.is_in_group("enemy"):
		inside_light.erase(body)
		if body.has_method("stop_burn"):
			body.stop_burn()
