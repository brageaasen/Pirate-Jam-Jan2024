extends TileMap

@export var max_x : int = 32
@export var max_y : int = 16

var y_block_offset = 6

var noise : FastNoiseLite = FastNoiseLite.new()

var snap_size_x : int = 16
var snap_size_y : int = 16

@onready var selector = $Selector

func _ready():
	noise.seed = randi()
	noise.fractal_octaves = 6
	noise.fractal_lacunarity = 2.5
	noise.fractal_gain = 0.4
	noise.fractal_weighted_strength = 0.5
	
	generate_level()

func generate_level():
	for x in range(-max_x, max_x):
		for y in max_y:
			var tile_id = generate_id(noise.get_noise_2d(x, y + y_block_offset))
			if tile_id != -1:
				var y_id = 0
				if randf() < 0.2:  # 20% chance
					y_id = 1
				set_cell(0, Vector2i(x, y + y_block_offset), tile_id, Vector2i(0, y_id))

func generate_id(noise_level : float):
	if noise_level <= -0.3:
		return -1
	else:
		return 0
