extends Node

class_name State

func enter() -> void:
	pass

func process(_delta: float) -> State:
	return self

func physics_process(_delta: float) -> State:
	return self

func exit() -> void:
	pass
