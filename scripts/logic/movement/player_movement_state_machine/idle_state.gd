class_name IdleState

extends BasePlayerMovementState

@export var walking_state: BasePlayerMovementState
@export var jumping_state: BasePlayerMovementState


func enter() -> void:
    horizontal_movement_store.decceleration = player_movement_resource.base_decceleration


func physics_process(delta: float) -> State:
    var direction = get_player_movement_direction()
    horizontal_movement_store.direction = direction
    HorizontalMovementLib.move_with_decceleration(player, horizontal_movement_store, delta)

    if Input.is_action_just_pressed(MainActions.jump):
        apply_jump()
        return jumping_state

    if direction:
        return walking_state

    return self
