extends Recource

@onready var tree_cut = $TreeCut

func _ready():
	super._ready()
	_name = "wood"
	tree_cut.emitting = true
	

func on_spawn():
	pass

func play_pickup_sound():
	pass

func on_pickup_item():
	player.get_node("Inventory").add(_name)
