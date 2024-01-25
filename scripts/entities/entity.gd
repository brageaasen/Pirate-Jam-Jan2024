extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var max_health : float = 100
var health : float

var dead


func take_damage(damage):
	if not dead:
		health -= damage
		if health <= 0:
			die()

func die():
	pass
