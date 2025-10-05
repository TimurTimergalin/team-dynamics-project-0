class_name CharacterBodyMoveAndSlideLogic

extends Node

signal after_move

@export var body: CharacterBody3D
@export var player_movement_resource: PlayerMovementResource


func _physics_process(_delta: float) -> void:
    var old_velocity := body.velocity
    var slided = body.move_and_slide()
    after_move.emit(old_velocity, body.velocity, slided)
