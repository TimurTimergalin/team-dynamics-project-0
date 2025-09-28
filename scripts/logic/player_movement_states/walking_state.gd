extends BasePlayerMovementState

@export var idle_state: BasePlayerMovementState

func process(_delta: float) -> State:
    var direction = get_player_movement_direction()
    horizontal_movement_store.direction = direction
    if not direction:
        return idle_state
    
    return self