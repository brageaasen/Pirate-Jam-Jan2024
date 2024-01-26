extends Recource

@onready var destroyed = $Destroyed

func _ready():
	super._ready()
	_name = "light_essence"
	destroyed.emitting = true
	

func on_spawn():
	pass

func play_pickup_sound():
	pass

func on_pickup_item():
	player.get_node("Inventory").add(_name)
