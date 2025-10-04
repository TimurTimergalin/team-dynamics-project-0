class_name State

extends Node


func enter() -> void:
    pass


func process(_delta: float) -> State:
    return self


func physics_process(_delta: float) -> State:
    return self


func exit() -> void:
    pass
