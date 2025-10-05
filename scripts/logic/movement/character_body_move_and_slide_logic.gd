class_name CharacterBodyMoveAndSlideLogic

extends Node

signal after_move

@export var body: CharacterBody3D
@export var player_movement_resource: PlayerMovementResource


func _ready() -> void:
    body.set_floor_max_angle(deg_to_rad(player_movement_resource.floor_max_angle))
    body.set_floor_constant_speed_enabled(player_movement_resource.is_floor_constant_speed)
    body.set_floor_snap_length(player_movement_resource.floor_snap_length)


func _physics_process(_delta: float) -> void:
    var old_velocity := body.velocity
    var slided = body.move_and_slide()
    after_move.emit(old_velocity, body.velocity, slided)
