class_name FiniteStateMachine
extends Node

@export var state : EnemyState

func _ready():
	change_state(state)

func change_state(new_state : EnemyState):
	if state is EnemyState:
		state._exit_state()
	new_state._enter_state()
	state = new_state
