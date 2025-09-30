extends State

class_name BasePlayerMovementState

@export var player: CharacterBody3D
@export var horizontal_movement_store: HorizontalMovementStore
@export var player_camera: Camera3D
@export var player_movement_resource: PlayerMovementResource

func get_player_movement_direction() -> Vector2:
	var input_direction = Input.get_vector(MainActions.move_left, MainActions.move_right, MainActions.move_forward, MainActions.move_backwards).normalized()

	var vector3_direction = (player_camera.global_basis * Vector3(input_direction.x, 0.0, input_direction.y)).normalized()
	return Vector2(vector3_direction.x, vector3_direction.z)

func is_running_input() -> bool:
	return (
		Input.is_action_pressed(MainActions.run) #and
		#Input.is_action_pressed(MainActions.move_forward) and
		#!Input.is_action_pressed(MainActions.move_backwards)
	) 
