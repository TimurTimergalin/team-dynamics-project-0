extends Node

class_name CharacterBodyMoveAndSlideLogic

@export var body: CharacterBody3D

signal after_move


func _physics_process(_delta: float) -> void:
    var old_velocity := body.velocity
    var slided = body.move_and_slide()
    after_move.emit(old_velocity, body.velocity, slided)
