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
	pass

func stop_swing():
	pass

func equip():
	equipped = true
	sprite.visible = true

func un_equip():
	equipped = false
	sprite.visible = false
	stop_swing()

func _on_swing_timer_timeout():
	pass
