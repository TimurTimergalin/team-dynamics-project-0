extends BasePlayerMovementState

@export var crouching_store: CrouchingStore

@export var walking_state: BasePlayerMovementState
@export var idle_state: BasePlayerMovementState

func enter() -> void:
    horizontal_movement_store.decceleration = player_movement_resource.base_decceleration
    horizontal_movement_store.acceleration = player_movement_resource.crouching_acceleration
    horizontal_movement_store.max_velocity = player_movement_resource.crouching_max_velocity

func process(_delta: float) -> State:
    var direction = get_player_movement_direction()
    horizontal_movement_store.direction = direction
    if !Input.is_action_pressed(MainActions.crouch):
        return (
            walking_state
            if direction
            else idle_state
        )
    
    return self
