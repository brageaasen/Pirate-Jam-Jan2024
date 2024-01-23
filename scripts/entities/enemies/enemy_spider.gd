extends "res://scripts/entities/enemies/enemy.gd"


@onready var fsm = $FiniteStateMachine as FiniteStateMachine
@onready var spider_wander_state = $FiniteStateMachine/SpiderWanderState as SpiderWanderState
@onready var spider_chase_state = $FiniteStateMachine/SpiderChaseState as SpiderChaseState
@onready var spider_attack_state = $FiniteStateMachine/SpiderAttackState as SpiderAttackState


func _ready():
	# On found_player, wander -> chase
	spider_wander_state.found_player.connect(fsm.change_state.bind(spider_chase_state))
	# On lost_player, chase -> wander
	spider_chase_state.lost_player.connect(fsm.change_state.bind(spider_wander_state))
	# On attack_player, chase -> wander
	spider_chase_state.attack_player.connect(fsm.change_state.bind(spider_attack_state))
	# On out_of_range, attack -> chase
	spider_attack_state.out_of_range.connect(fsm.change_state.bind(spider_chase_state))

func attack():
	pass
