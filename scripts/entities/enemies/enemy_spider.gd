extends "res://scripts/entities/enemies/enemy.gd"

@export var jump_height = 500
@export var attack_damage = 20

var inside_detect_radius = []
var inside_attack_radius = []

var audio_manager : AudioManager


@onready var fsm = $FiniteStateMachine as FiniteStateMachine
@onready var spider_idle_state = $FiniteStateMachine/SpiderIdleState as SpiderIdleState
@onready var spider_wander_state = $FiniteStateMachine/SpiderWanderState as SpiderWanderState
@onready var spider_chase_state = $FiniteStateMachine/SpiderChaseState as SpiderChaseState
@onready var spider_jump_state = $FiniteStateMachine/SpiderJumpState as SpiderJumpState
@onready var spider_attack_state = $FiniteStateMachine/SpiderAttackState as SpiderAttackState
@onready var spider_hurt_state = $FiniteStateMachine/SpiderHurtState as SpiderHurtState

func _ready():
	super._ready()
	audio_manager = get_node("/root/Game/AudioManager")
	
	# On chase, idle -> chase
	spider_idle_state.chase.connect(fsm.change_state.bind(spider_chase_state))
	# On landed, jump -> idle
	spider_jump_state.landed.connect(fsm.change_state.bind(spider_idle_state))
	# On attack, idle -> attack
	spider_idle_state.attack.connect(fsm.change_state.bind(spider_attack_state))
	# On attack, chase -> attack
	spider_chase_state.attack.connect(fsm.change_state.bind(spider_attack_state))
	# On jump, chase -> jump
	spider_chase_state.jump.connect(fsm.change_state.bind(spider_jump_state))
	# On out_of_range, attack -> idle
	spider_attack_state.out_of_range.connect(fsm.change_state.bind(spider_idle_state))
	# On finished, hurt -> idle
	spider_hurt_state.finished.connect(fsm.change_state.bind(spider_idle_state))

func take_damage(damage):
	if not dead:
		# Play damage particles / animation
		fsm.change_state(spider_hurt_state)
		health -= damage
		if health <= 0:
			die()

func _on_detect_radius_body_entered(body):
	if body.name == "Player":
		inside_detect_radius.append(body)

func _on_detect_radius_body_exited(body):
	if body.name == "Player":
		inside_detect_radius.erase(body)


func _on_attack_radius_body_entered(body):
	if body.name == "Player":
		inside_attack_radius.append(body)


func _on_attack_radius_body_exited(body):
	if body.name == "Player":
		inside_attack_radius.erase(body)
