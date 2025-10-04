extends StateMachine

@export var move_and_slide_logic: CharacterBodyMoveAndSlideLogic


func _ready() -> void:
    move_and_slide_logic.after_move.connect(after_move)


func after_move(old_velocity, new_velocity, slided) -> void:
    var new_state = cur_state.after_move(old_velocity, new_velocity, slided)
    swap_state(new_state)
