extends "res://scripts/abilities/ability.gd"

@export var speed = 20
@export var radius : float = 20
@onready var magnet_radius = $MagnetRadius
var inside_radius = []


func _ready():
	_name = "loot_magnet"
	$MagnetRadius/CollisionShape2D.shape.radius = radius
	$MagnetRadius.body_entered.connect(_on_magnet_radius_area_entered)
	$MagnetRadius.body_exited.connect(_on_magnet_radius_area_exited)

func _physics_process(_delta):
	magnet_radius.position = get_parent().global_position
	for rb : RigidBody2D in inside_radius:
		var _direction = (get_parent().global_position - rb.global_position).normalized()
		rb.linear_velocity = _direction * speed

func execute(_s):
	$MagnetRadius/CollisionShape2D.shape.radius = radius
	$MagnetRadius.body_entered.connect(_on_magnet_radius_area_entered)
	$MagnetRadius.body_exited.connect(_on_magnet_radius_area_exited)

func _on_magnet_radius_area_entered(rb):
	if rb.is_in_group("recource"):
		inside_radius.append(rb)

func _on_magnet_radius_area_exited(rb):
	if rb.is_in_group("recource"):
		inside_radius.erase(rb)
