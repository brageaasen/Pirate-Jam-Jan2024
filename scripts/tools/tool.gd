extends Area2D

@export var equipped = false

@export var swing_time : float = 0.25

var is_swinging = false

@onready var swing_timer = $SwingTimer
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite

@onready var player = $"../.."
@onready var body = player.get_node("Body")

func look_at_mouse():
	pass

func flip():
	position.x *= -1

func start_swing():
	is_swinging = true
	swing_timer.start(swing_time)
	animation_player.play("swing")
	#animation_player.set_speed(1 / swing_time)

func stop_swing():
	is_swinging = false
	swing_timer.stop()
	animation_player.stop()

func equip():
	equipped = true
	sprite.visible = true

func un_equip():
	equipped = false
	sprite.visible = false
	stop_swing()

func _on_swing_timer_timeout():
	pass
