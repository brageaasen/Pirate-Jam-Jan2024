class_name SpiderChaseState

extends EnemyState

@export var actor : Enemy
@export var animator : AnimationPlayer

var player
var distance_to_player

signal lost_player
signal attack
signal jump

func _ready() -> void:
	set_physics_process(false)
	player = get_node("/root/Game/World/Player")

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("move")

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
	if player:
		actor.audio_manager.play_random_sound(actor.audio_manager.spider_run_sounds)
		distance_to_player = (player.global_position - actor.global_position)
		actor.velocity = distance_to_player.normalized()
		actor.velocity *= actor.max_speed
		if not actor.is_on_floor():
			actor.velocity.y += actor.gravity
		
		actor.move_and_slide()
	
		# Flip sprite based on player's position
		if player.global_position.x < actor.global_position.x:
			actor.body.scale.x = -abs(actor.body.scale.x)  # Flip to left
		else:
			actor.body.scale.x = abs(actor.body.scale.x)  # Flip to right
		
		# Check if enemy tank should change current state to attack
		if actor.inside_attack_radius.size() != 0:
			attack.emit()
		
		# Check if enemy tank should change current state to jump
		if abs(distance_to_player.x) > 120:
			jump.emit()
			actor.velocity.x = 0
