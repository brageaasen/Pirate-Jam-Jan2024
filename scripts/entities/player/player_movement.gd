extends "res://scripts/entities/player/player.gd"

@export var speed = 60
@export var jump_force = 250
@export var gravity = 750
@export var friction = 0.5
@export var acceleration = 0.2


func _physics_process(delta: float) -> void:
	var dir = get_direction()
	var is_jump_interupted = Input.is_action_just_released("jump") and velocity.y < 0.0
	velocity = calculate_velocity(velocity, dir, is_jump_interupted, speed, jump_force, delta)
	move_and_slide()


func get_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)

func calculate_velocity(curVelocity, dir, is_jump_interupted, speed, jump_force, delta):
	var out = Vector2.ZERO

	if dir.x != 0:
		out.x = lerp(curVelocity.x, dir.x * speed, acceleration)
	else:
		out.x = lerp(curVelocity.x, 0.0, friction)

	if(dir.y == -1.0): # Jumping
		out.y = dir.y * jump_force
	else: # Falling
		out.y = curVelocity.y + (gravity * delta)

	if(is_jump_interupted): # jump key release
		out.y = 0.0 + (gravity * delta)

	return out
