extends Node2D

#@onready var main_camera = $MainCamera
#@onready var player = $Player

func _ready():
	connect_signals()

func _process(delta):
	pass
	#main_camera.position.x = player.position.x

func connect_signals():
	for child in get_children():
		if "Tree" in child.name:
			child.get_node("TreeRb").connect("died", _on_tree_died)

func _on_tree_died(wood_drop, explosion_particles, _position):
	#var p = explosion_particles.instantiate()
	#add_child(p)
	#p.global_position = _position
	
	for i in range(0, randi_range(2, 3)):
		call_deferred("item_spawn", wood_drop, _position)
	
func item_spawn(drop, _position):
	var random_angle
	var random_direction
	random_angle = randf_range(0, 360)
	random_direction = Vector2.RIGHT.rotated(deg_to_rad(random_angle))
	var item = drop.instantiate()
	add_child(item)
	item.spawn(_position, random_direction)
