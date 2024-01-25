class_name SpiderIdleState
extends EnemyState

@export var actor : Enemy
@export var animator : AnimationPlayer

var player

signal attack
signal chase

func _ready():
	set_physics_process(false)
	player = get_node("/root/Game/World/Player")

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("idle")

func _exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	if actor.inside_attack_radius.size() != 0:
		attack.emit()
	elif actor.inside_detect_radius.size() != 0:
		chase.emit()
