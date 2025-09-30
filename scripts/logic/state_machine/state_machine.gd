extends Node

class_name StateMachine

@export var cur_state: State

signal state_changed

func swap_state(new_state: State):
	if new_state == cur_state:
		return
	state_changed.emit(cur_state, new_state)
	cur_state.exit()
	new_state.enter()
	cur_state = new_state

func _ready() -> void:
	assert(cur_state != null)
	cur_state.enter()

func _process(delta):
	var new_state = cur_state.process(delta)
	swap_state(new_state)

func _physics_process(delta):
	var new_state = cur_state.physics_process(delta)
	swap_state(new_state)
