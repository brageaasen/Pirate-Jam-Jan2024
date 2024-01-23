class_name SpiderAttackState

extends EnemyState

@export var actor : Enemy
@export var animator : AnimationPlayer

var player

signal lost_player
signal out_of_range

func _ready() -> void:
	set_physics_process(false)
	player = get_node("/root/Game/World/Player")

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("idle")

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
	if actor.target:
		pass
	# Check if enemy tank should change current state to wander
	if not actor.target:
		lost_player.emit()
	
	# Check if enemy tank should change current state to chase
	var distance_to_player = actor.global_position.distance_to(player.global_position)
	if (actor.attack_range < distance_to_player):
		out_of_range.emit()
