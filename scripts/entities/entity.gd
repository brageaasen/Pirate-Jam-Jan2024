extends CharacterBody2D


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
