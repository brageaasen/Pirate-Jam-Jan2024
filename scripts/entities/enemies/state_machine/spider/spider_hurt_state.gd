class_name SpiderHurtState
extends EnemyState

@export var actor : Enemy
@export var animator : AnimationPlayer

var player

signal finished

func _ready():
	set_physics_process(false)
	player = get_node("/root/Game/World/Player")

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("take_damage")

func _exit_state() -> void:
	set_physics_process(false)


func _physics_process(delta):
	if not actor.is_on_floor():
		actor.velocity.y = actor.gravity / 3
		actor.velocity.x = actor.velocity.x * 0.95
	else:
		actor.velocity.y = 0
		actor.velocity.x = 0
	if animator.current_animation != "take_damage" and actor.is_on_floor():
		finished.emit()
	
	
	actor.move_and_slide()
