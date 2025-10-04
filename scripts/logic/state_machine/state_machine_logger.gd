extends Node

class_name StateMachineLogger

@export var state_machine: StateMachine
@export var machine_name: String = "Anonymous State Machine"


func _ready() -> void:
    state_machine.state_changed.connect(
        func(from, to): print(machine_name, " changed its state from ", from, " to ", to)
    )
