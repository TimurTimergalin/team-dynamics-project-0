class_name PlayerMovementResource

extends Resource

@export var walking_max_velocity: float = 15
@export var walking_acceleration: float = 50
@export var base_decceleration: float = 80  # Должно быть не меньше, чем ускорение
@export var crouching_max_velocity: float = 5
@export var crouching_acceleration: float = 50
@export var jumping_max_velocity: float = 10
@export var jumping_acceleration: float = 10
@export var jumping_decceleration: float = 20  # Должно быть не меньше, чем ускорение
@export var jumping_initial_velocity: float = 80
@export var jumping_max_control_retention: float = 20  # Должно быть не меньше, чем jumping_max_velocity

@export var free_fall_acceleration: float = -15
@export var free_fall_decceleration: float = -9.8
