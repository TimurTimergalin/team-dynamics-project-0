class_name CameraLogic
extends Node

const SENSITIVITY := 0.01

@export var camera_holder: Node3D
@export var camera: Camera3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func _unhandled_input(_event: InputEvent) -> void:
	pass	
	
func _process(delta: float) -> void:
	var mouse_velocity := Input.get_last_mouse_velocity()
	camera_holder.rotate_y(-mouse_velocity.x * SENSITIVITY * delta)
	camera.rotate_x(-mouse_velocity.y * SENSITIVITY * delta)
	
