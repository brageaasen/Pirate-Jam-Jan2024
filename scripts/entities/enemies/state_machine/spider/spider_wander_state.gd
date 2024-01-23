class_name SpiderWanderState
extends EnemyState

@export var actor : Enemy
@export var animator : AnimationPlayer

@onready var enemy_tank = $"../.."
@onready var body = $"../../Body"

var player

signal found_player


func _ready():
	set_physics_process(false)
	player = get_node("/root/Game/World/Player")

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("move")

func _exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	actor.velocity = actor.velocity.limit_length(actor.max_speed)
	actor.move_and_slide()
	
	# Emit found player and change states if player is found
	if actor.target: # TODO:
		found_player.emit()
