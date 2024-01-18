extends TileMap

@export var max_x : int = 32
@export var max_y : int = 8

var noise : FastNoiseLite = FastNoiseLite.new()

var snap_size_x : int = 16
var snap_size_y : int = 16

@onready var selector = $Selector

func _ready():
	noise.seed = randi()
	noise.fractal_octaves = 5
	noise.fractal_lacunarity = 2
	noise.fractal_gain = 0.8
	noise.fractal_weighted_strength = 0
	
	generate_level()

func generate_level():
	for x in max_x:
		for y in max_y:
			var tile_id = generate_id(noise.get_noise_2d(x, y))
			if tile_id != -1:
				set_cell(0, Vector2i(x, y), tile_id, Vector2i(1, 1))

func generate_id(noise_level : float):
	if noise_level <= -0.3:
		return -1
	else:
		return 0

func _physics_process(delta):
	return
	if Input.is_action_just_pressed("mb_left"):
		var tile : Vector2 = local_to_map(selector.mouse_pos * 16)
		var tile_id = get_cell_atlas_coords(0, tile)
		var source_id = get_cell_source_id(0, tile)
		if source_id == -1: return
		var new_id = 1
		if tile_id.x < 5:
			new_id = tile_id.x + 1
			set_cell(0, tile, 0, Vector2(new_id, 1))
