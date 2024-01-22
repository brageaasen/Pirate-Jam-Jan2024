extends Node2D

@onready var flame_animation = $FlameAnimation
@onready var spark_down = $SparkDown
@onready var spark_side = $SparkSide

func _ready():
	spark_down.emitting = false
	spark_side.emitting = false
	flame_animation.visible = false


func exit():
	spark_down.emitting = false
	spark_side.emitting = false
	flame_animation.visible = false

func play_fly_up():
	spark_side.emitting = false
	
	flame_animation.visible = true
	flame_animation.play("fly_up")
	spark_down.emitting = true

func play_fly_side():
	spark_down.emitting = false
	
	flame_animation.visible = true
	flame_animation.play("fly_side")
	spark_side.emitting = true
