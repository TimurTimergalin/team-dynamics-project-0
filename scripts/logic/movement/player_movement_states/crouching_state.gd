extends BasePlayerMovementState

@export var walking_state: BasePlayerMovementState
@export var idle_state: BasePlayerMovementState

func enter() -> void:
    horizontal_movement_store.decceleration = player_movement_resource.base_decceleration
    horizontal_movement_store.acceleration = player_movement_resource.crouching_acceleration
    horizontal_movement_store.max_velocity = player_movement_resource.crouching_max_velocity

func physics_process(delta: float) -> State:
    var direction = get_player_movement_direction()
    horizontal_movement_store.direction = direction
    HorizontalMovementLib.process(player, horizontal_movement_store, delta)
    if !Input.is_action_pressed(MainActions.crouch):
        if direction:
            return walking_state
        else:
            return idle_state
    
    return self
