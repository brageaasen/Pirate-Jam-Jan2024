extends Node


@onready var spawn_timer = $SpawnTimer
@onready var spawn_location = $SpawnLocation

@export var enemies_to_spawn = {}
@export var time_to_spawn : float

@export var spawn_distance_from_player : float
var spiders_to_spawn : int
var tiny_spiders_to_spawn : int

var player

signal spawn_enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Game/World/Player")
	spawn_timer.wait_time = time_to_spawn

func spawn_enemies():
	# Set spawn location to random side of player x
	if randi() % 2 == 0:
		spawn_location.global_position.x *= -1
	else:
		# Not needed
		spawn_location.global_position.x *= 1 
	
	## 50/50 which enemy gets to spawn
	# Offset for enemy spawn location
	var random_offset = Vector2(randf_range(-50, 50), 0)
	# Spawn large spiders swarm
	if randi() % 2:
		for i in spiders_to_spawn:
			emit_signal("spawn_enemy", enemies_to_spawn["spider_enemy"], spawn_location.global_position + random_offset)
	# Spawn tiny spiders swarm
	else:
		for i in tiny_spiders_to_spawn:
			emit_signal("spawn_enemy", enemies_to_spawn["tiny_spider_enemy"], spawn_location.global_position + random_offset)

func _on_spawn_timer_timeout():
	spawn_enemies()
