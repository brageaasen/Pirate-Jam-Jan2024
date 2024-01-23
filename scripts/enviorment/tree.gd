extends RigidBody2D

@export var max_health = 150
var health
var dead = false
var cut = false

@export var wood_drop : PackedScene

signal died

@onready var collision_roll : CollisionShape2D = $CollisionRoll


func _ready():
	health = max_health

func _physics_process(delta):
	pass


func take_damage(damage):
	if not dead:
		health -= damage
		if not cut and health <= max_health / 1.2:
			fall()
		if health <= 0:
			die()

func fall():
	cut = true
	collision_roll.disabled = false
	# Apply an initial force to make the tree fall
	var force_direction = 10 if randi() % 2 == 0 else -10
	set_axis_velocity(Vector2(force_direction,0))

func die():
	# Spawn loot
	
	# Play particles
	
	# emit signal
	emit_signal("died", wood_drop, null, global_position)
	
	# Free object
	queue_free()
	pass

func _on_body_entered(body):
	pass # Replace with function body.


func _on_body_exited(body):
	pass # Replace with function body.
