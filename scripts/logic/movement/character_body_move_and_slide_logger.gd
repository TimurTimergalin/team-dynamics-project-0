class_name CharacterBodyMoveAndSlideLogger

extends Node


func _on_move_and_slide(_old_velocity, cur_velocity, _slided) -> void:
    print("Current velocity: ", cur_velocity)
    #print("Old velocity: ", old_velocity, "Current velocity: ", cur_velocity, "Slided: ", slided)
