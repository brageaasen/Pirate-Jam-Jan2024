extends State

class_name GroundState

@export var jump_velocity : float = -150.0
@export var air_state : State
@export var jump_animation : String = "jump"
@export var walk_animation : String = "walk"
@export var run_animation : String = "run"
var player

@onready var tool = $"../../Tool"
@onready var animation_player = $"../../AnimationPlayer"

@onready var drill = $"../../HandEquip/Drill"
@onready var saw = $"../../HandEquip/Saw"
@onready var flash_light = $"../../HandEquip/FlashLight"
var all_tools

func _ready():
	player = get_parent().get_parent()
	all_tools = [drill, saw, flash_light]

func state_process(delta):
	if !character.is_on_floor():
		next_state = air_state

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()
	
	if event.is_action_pressed("equip_1"):
		handle_equipment(drill)
	elif event.is_action_pressed("equip_2"):
		handle_equipment(saw)
	elif event.is_action_pressed("equip_3"):
		handle_equipment(flash_light)


func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)

func walk():
	# Decrease speed of player
	player.speed = 40
	# Change animation
	playback.travel(walk_animation)

func run():
	# Increase speed of player
	player.speed = 80
	# Change animation
	playback.travel(run_animation)

func handle_equipment(equip_tool):
	if equip_tool.equipped:
		equip_tool.un_equip()
		run()
		return
	for tool in all_tools:
		tool.un_equip()
	equip_tool.equip()
	walk()
