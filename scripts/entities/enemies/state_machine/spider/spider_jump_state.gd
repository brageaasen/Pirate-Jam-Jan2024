class_name SpiderJumpState

extends EnemyState

@export var actor : Enemy
@export var animator : AnimationPlayer

var player

signal landed
signal attack_player

func _ready() -> void:
	set_physics_process(false)
	player = get_node("/root/Game/World/Player")

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("jump")

func _exit_state() -> void:
	set_physics_process(false)

func jump_to_player():
	if actor.is_on_floor():
		var jump_distance = (player.get_global_position() - actor.get_global_position()).normalized()
		actor.velocity = jump_distance
		actor.velocity.x *= actor.max_speed * actor.jump_length * randf_range(0.8, 1.2)
		actor.velocity.y = -actor.jump_height

func _physics_process(delta) -> void:
	if actor.is_on_floor() and !actor.animation_player.is_playing():
		actor.velocity.x = 0
		# Change state to idle when landed
		landed.emit()
		
	actor.velocity.y += actor.gravity * delta
	actor.move_and_slide()
	if player:
		# Flip sprite based on player's position
		if player.global_position.x < actor.global_position.x:
			actor.body.scale.x = -abs(actor.body.scale.x)  # Flip to left
		else:
			actor.body.scale.x = abs(actor.body.scale.x)  # Flip to right
