extends Sprite2D

var snap_size_x : int = 16
var snap_size_y : int = 16

var mouse_pos : Vector2 = Vector2.ZERO

func _physics_process(delta):
	update_position_snapped()

func update_position_snapped():
	mouse_pos = Vector2(int(get_global_mouse_position().x / snap_size_x),
						int(get_global_mouse_position().y / snap_size_y))
	global_position = mouse_pos * snap_size_x
