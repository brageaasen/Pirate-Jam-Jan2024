class_name SpiderAttackState

extends EnemyState

@export var actor : Enemy
@export var animator : AnimationPlayer

var player
var force = 10

signal out_of_range

func _ready() -> void:
	set_physics_process(false)
	player = get_node("/root/Game/World/Player")

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("attack")
	actor.velocity = Vector2.ZERO

func _exit_state() -> void:
	set_physics_process(false)

func attack():
	for body in actor.inside_attack_radius:
		if body.has_method("take_damage"):
			body.take_damage(actor.attack_damage)

func push_enemy():
	var direction = -(actor.global_position - player.global_position).normalized()
	actor.velocity.x += direction.x * force


func _physics_process(delta) -> void:
	if actor.inside_attack_radius.size() == 0 and !actor.animation_player.is_playing():
		out_of_range.emit()
	elif !actor.animation_player.is_playing():
		actor.velocity.x = 0
		animator.play("attack")
	actor.move_and_slide()
