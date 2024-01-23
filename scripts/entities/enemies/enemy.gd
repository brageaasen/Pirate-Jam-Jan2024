class_name Enemy
extends "res://scripts/entities/entity.gd"

signal attack_signal
signal health_changed
signal died

# Movement
@export var max_speed = 40.0

# Combat
@export var attack_range : float = 60
@export var detect_radius : int
var can_attack = true
var target = null

func _ready():
	health = max_health
	emit_signal("health_changed", health * 100.0/max_health)
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius

func attack():
	pass
