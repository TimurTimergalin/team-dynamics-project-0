extends BasePlayerMovementState

@export var walking_state: BasePlayerMovementState
@export var crouching_state: BasePlayerMovementState
@export var running_state: BasePlayerMovementState

func enter() -> void:
	horizontal_movement_store.decceleration = player_movement_resource.base_decceleration
	horizontal_movement_store.acceleration = 0
	horizontal_movement_store.max_velocity = 0

func process(_delta: float) -> State:
	var direction = get_player_movement_direction()
	horizontal_movement_store.direction = direction
	if Input.is_action_pressed(MainActions.crouch):
		return crouching_state

	if direction:
		return (
			running_state
			if is_running_input()
			else walking_state
		)
	
	return self
