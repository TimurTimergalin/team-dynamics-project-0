extends BasePlayerMovementState

@export var walking_state: BasePlayerMovementState

func process(_delta: float) -> State:
    var direction = get_player_movement_direction()
    horizontal_movement_store.direction = direction
    if direction:
        return walking_state
    
    return self
