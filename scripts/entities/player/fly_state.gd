extends State

class_name FlyState

@export var landing_state : State
@export var air_state : State

@export var landing_animation : String = "landing"
@export var fall_animation : String = "fall"

@export var fly_velocity : float = -50

@onready var fly_flame = $"../../FlyFlame"


func state_process(delta):
	if character.is_on_floor():
		next_state = landing_state
	
	if Input.get_vector("move_left", "move_right", "ui_up", "ui_down") == Vector2.ZERO:
		fly_flame.play_fly_up()
	else:
		fly_flame.play_fly_side()
	
	fly()

func state_input(event : InputEvent):
	if event.is_action_released("jump"): # && has_double_jumped:
		next_state = air_state

func on_exit():
	fly_flame.exit()
	
	if next_state == landing_state:
		playback.travel(landing_animation)
	if next_state == air_state:
		playback.travel(fall_animation)
		
func fly():
	character.velocity.y = fly_velocity

