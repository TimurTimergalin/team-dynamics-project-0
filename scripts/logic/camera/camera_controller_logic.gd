class_name CameraControllerLogic
extends Node

@export var camera_holder: Node3D
@export var camera: Camera3D
@export var cam_res: CameraControllerResource

var is_cam_down: bool = false

func _ready() -> void:
	camera.fov = cam_res.fov
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func _unhandled_input(_event: InputEvent) -> void:
	if _event is InputEventMouseMotion:
		camera_holder.rotate_y(-_event.relative.x * cam_res.sens)
		camera.rotate_x(-_event.relative.y * cam_res.sens)	
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-cam_res.down_look_limit), deg_to_rad(cam_res.up_look_limit))	

func _on_state_changed(from_state, to_state) -> void:
	if to_state is CrouchingState:
		camera_holder.position.y -= 1
	elif from_state is CrouchingState:
		camera_holder.position.y += 1
	
