extends Camera2D

@export var shake_base_amount : float = 1.0
@export var shake_dampening : float = 0.075
var shake_amount : float = 0.0

@export var transition_speed: float = 0.5
var target_zoom: float = 8
var transitioning: bool = false

@export var init_light_scale = 8
var current_zoom = zoom.x
var in_cave = false

@onready var point_light_2d = $"../PointLight2D"

func _ready():
	change_light_scale(init_light_scale)

func _process(delta):
	if shake_amount > 0:
		position.x = randf_range(-shake_base_amount, shake_base_amount) * shake_amount
		position.y = randf_range(-shake_base_amount, shake_base_amount) * shake_amount
		shake_amount = lerp(shake_amount, 0.0, shake_dampening)
	else:
		position = Vector2(0, 0)
	
	if get_parent().global_position.y > 0 and !in_cave: # Player is in cave
		in_cave = true
		change_light_scale(init_light_scale)
	elif get_parent().global_position.y < 0 and in_cave:
		in_cave = false
		change_light_scale(current_zoom)
		
	if transitioning:
		if not target_zoom < 2.8:
			current_zoom = lerp(current_zoom, target_zoom, transition_speed * delta)
			zoom = Vector2(current_zoom, current_zoom)
		var new_light_size = lerp(current_zoom, target_zoom, transition_speed * delta)
		point_light_2d.texture_scale = 1 + (8 - new_light_size) / 2
		point_light_2d.base_scale = point_light_2d.texture_scale

		if abs(current_zoom - target_zoom) < 0.01:
			transitioning = false


func shake(magnitude : float):
	shake_amount += magnitude


func change_light_scale(new_zoom  : float):
	target_zoom = new_zoom
	transitioning = true
