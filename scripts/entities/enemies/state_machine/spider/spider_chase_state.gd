class_name SpiderChaseState

extends EnemyState

@export var actor : Enemy
@export var animator : AnimationPlayer

var player

signal lost_player
signal attack_player

func _ready() -> void:
	set_physics_process(false)
	player = get_node("/root/Game/World/Player")

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("move")

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
	if actor.target:
		# Check if enemy tank should change current state to attack
		var distance_to_player = actor.global_position.distance_to(player.global_position)
		if (actor.attack_range >= distance_to_player):
			attack_player.emit()
	
	#if not actor.target or collider != player:
	#	lost_player.emit()
	#	collider = null
