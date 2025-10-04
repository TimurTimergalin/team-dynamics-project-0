extends State

class_name BasePlayerMovementState

@export var player: CharacterBody3D
@export var horizontal_movement_store: HorizontalMovementStore
@export var player_camera: Camera3D
@export var player_movement_resource: PlayerMovementResource


func get_player_movement_direction() -> Vector2:
    var input_direction = (
        Input
        . get_vector(
            MainActions.move_left,
            MainActions.move_right,
            MainActions.move_forward,
            MainActions.move_backwards
        )
        . normalized()
    )

    var vector3_direction = (
        player_camera.global_basis * Vector3(input_direction.x, 0.0, input_direction.y)
    )
    return Vector2(vector3_direction.x, vector3_direction.z).normalized()


func apply_jump():
    player.velocity.y += player_movement_resource.jumping_initial_velocity
    horizontal_movement_store.currently_applied_movement = (
        horizontal_movement_store
        . currently_applied_movement
        . limit_length(player_movement_resource.jumping_max_control_retention)
    )


func after_move(
    old_velocity: Vector3, new_velocity: Vector3, slided: bool
) -> BasePlayerMovementState:
    if slided:
        HorizontalMovementLib.handle_slided(horizontal_movement_store, old_velocity, new_velocity)
    return self
