class_name WalkingState
extends BasePlayerMovementState

@export var idle_state: BasePlayerMovementState
@export var jumping_state: BasePlayerMovementState
@export var feet_area_detectors: FourDirectional
@export var stairs_fit_checks: FourDirectional


func enter() -> void:
    horizontal_movement_store.decceleration = player_movement_resource.base_decceleration
    horizontal_movement_store.acceleration = player_movement_resource.walking_acceleration
    horizontal_movement_store.max_velocity = player_movement_resource.walking_max_velocity


func physics_process(delta: float) -> State:
    var direction = get_player_movement_direction()
    horizontal_movement_store.direction = direction
    HorizontalMovementLib.move_with_decceleration(player, horizontal_movement_store, delta)

    if Input.is_action_just_pressed(MainActions.jump):
        apply_jump()
        return jumping_state

    if not direction:
        return idle_state

    return self


func after_move(old_velocity: Vector3, new_velocity: Vector3, slided: bool) -> BasePlayerMovementState:
    if slided:
        var skip_occured := CollisionMovement.skip_stairs(
            old_velocity,
            player,
            player.get_last_slide_collision(),
            feet_area_detectors,
            stairs_fit_checks,
            player_movement_resource.max_stair_angle,
            player_movement_resource.stairs_fit_checks_height
        )
        if not skip_occured:
            HorizontalMovementLib.handle_slided(horizontal_movement_store, old_velocity, new_velocity)
    return self
