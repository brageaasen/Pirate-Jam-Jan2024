class_name Enemy
extends "res://scripts/entities/entity.gd"

signal attack_signal
signal health_changed
signal died

# Movement
@export var max_speed = 40.0
@export var jump_length = 4

# Combat
@export var attack_range : float = 60
var can_attack = true
var target = null

var animation_player

@onready var burn_timer = $BurnTimer
@onready var body = $Body

func _ready():
	animation_player = get_node("AnimationPlayer")
	health = max_health
	emit_signal("health_changed", health * 100.0/max_health)

func take_damage(damage):
	if not dead:
		# Play damage particles / animation
		animation_player.play("take_damage")
		health -= damage
		if health <= 0:
			die()

func die():
	# Play explode particles on main scene
	queue_free()

var is_burning
var burn_damage
func burn(damage):
	if is_burning:
		return
	# Play burn particles
	#$Burn.emitting = true
	# Apply damage
	is_burning = true
	burn_damage = damage
	take_damage(damage)
	burn_timer.start()

func stop_burn():
	is_burning = false
	burn_timer.stop()

func _on_burn_timer_timeout():
	is_burning = false
	burn(burn_damage)

func attack():
	pass


