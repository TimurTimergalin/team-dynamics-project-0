extends Node

class_name CharacterBodyMoveAndSlideLogic

@export var body: CharacterBody3D

signal slided

func _physics_process(_delta: float) -> void:
    var velocity := body.velocity
    if body.move_and_slide():
        slided.emit(velocity, body.get_last_slide_collision())
