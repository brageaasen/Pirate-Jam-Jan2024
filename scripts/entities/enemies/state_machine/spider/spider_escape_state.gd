class_name SpiderEscapeState

extends EnemyState

@export var actor : Enemy
@export var animator : AnimationPlayer

var player
var escape_path


func _ready() -> void:
	set_physics_process(false)
	player = get_node("/root/Game/World/Player")

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("move")
	actor.max_speed *= 2.5

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
	if player:
		escape_path = -(player.global_position - actor.global_position)
		escape_path.x *= 10
		actor.velocity = escape_path.normalized()
		actor.velocity *= actor.max_speed
		if not actor.is_on_floor():
			actor.velocity.y += actor.gravity
		
		actor.move_and_slide()
	
		# Flip sprite based on player's position (look away from player)
		if player.global_position.x < actor.global_position.x:
			actor.body.scale.x = abs(actor.body.scale.x)  # Flip to right
		else:
			actor.body.scale.x = -abs(actor.body.scale.x)  # Flip to left
