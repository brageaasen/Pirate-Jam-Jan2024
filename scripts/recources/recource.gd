class_name Recource

extends RigidBody2D

var audio_manager
var player

@export var should_rotate : bool
@export var lifetime : float = 30
@export var speed = 10

var _name : String

func _ready():
	#audio_manager = get_node("/root/Game/AudioManager")
	player = get_node("/root/Game/World/Player")

func _process(delta):
	# Make sprite more transparent to show lifetime left
	if $Lifetime.time_left < $Lifetime.wait_time / 5:
		$Body.modulate.a = 0.8

func spawn(_position, _direction):
	self.on_spawn()
	position = _position
	if should_rotate:
		rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	$Lifetime.start()

func _on_lifetime_timeout():
	queue_free()

func _on_pickup_radius_body_entered(body):
	if body.name == "Player":
		on_pickup_item()
		play_pickup_sound()
		queue_free()

func on_spawn():
	pass

func play_pickup_sound():
	pass

func on_pickup_item():
	pass
