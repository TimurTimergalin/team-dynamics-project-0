extends BasePlayerMovementState

@export var crouching_state: BasePlayerMovementState
@export var walking_state: BasePlayerMovementState
@export var idle_state: BasePlayerMovementState


func enter() -> void:
    horizontal_movement_store.acceleration = player_movement_resource.jumping_acceleration
    horizontal_movement_store.decceleration = player_movement_resource.jumping_decceleration
    horizontal_movement_store.max_velocity = player_movement_resource.jumping_max_velocity


func physics_process(delta: float) -> State:
    var direction = get_player_movement_direction()
    horizontal_movement_store.direction = direction
    if horizontal_movement_store.decceleration == 0:
        HorizontalMovementLib.move_without_decceleration(player, horizontal_movement_store, delta)
    else:
        HorizontalMovementLib.move_with_decceleration(player, horizontal_movement_store, delta)
    return self


func after_move(_old_velocity: Vector3, _new_velocity: Vector3, _slided: bool) -> BasePlayerMovementState:
    super.after_move(_old_velocity, _new_velocity, _slided)
    if not player.is_on_floor():
        return self

    horizontal_movement_store.currently_applied_movement = Vector2(player.velocity.x, player.velocity.z)
    if Input.is_action_pressed(MainActions.crouch):
        return crouching_state

    if horizontal_movement_store.direction:
        return walking_state

    return idle_state
