extends Label

@export var character_state_machine : CharacterStateMachine

func _process(delta):
	text = "State: " + character_state_machine.current_state.name
