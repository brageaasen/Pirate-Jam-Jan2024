extends PointLight2D

var base_scale
@export var pulse_range = 0.1
@export var pulse_speed = 2.0

func _ready():
	base_scale = 10  # Set the base scale to the current texture scale

func _process(delta):
	var time = Time.get_ticks_msec() / 1000.0  # Convert milliseconds to seconds
	var pulse = sin(time * pulse_speed) * pulse_range
	texture_scale = base_scale + pulse
