extends BasePlayerMovementState

@export var idle_state: BasePlayerMovementState
@export var crouching_state: BasePlayerMovementState

func enter() -> void:
	horizontal_movement_store.decceleration = player_movement_resource.base_decceleration
	horizontal_movement_store.acceleration = player_movement_resource.walking_acceleration
	horizontal_movement_store.max_velocity = player_movement_resource.walking_max_velocity

func physics_process(delta: float) -> State:
	var direction = get_player_movement_direction()
	horizontal_movement_store.direction = direction
	HorizontalMovementLib.process(player, horizontal_movement_store, delta)
	if Input.is_action_pressed(MainActions.crouch):
		return crouching_state

	if not direction:
		return idle_state
	
	return self
