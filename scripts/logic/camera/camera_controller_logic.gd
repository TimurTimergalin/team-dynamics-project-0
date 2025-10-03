class_name CameraControllerLogic
extends Node

@export var camera_holder: Node3D
@export var camera: Camera3D
@export var cam_res: CameraControllerResource
@export var camera_player: AnimationPlayer

const CAMERA_CROUCH :=  "camera_crouch"

func _ready() -> void:
	camera.fov = cam_res.fov
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#var crouch_anim = camera_player.get_animation(CAMERA_CROUCH)
	#crouch_anim.track_set_key_value(0, 1, Vector3(0, -2, 0))
	
func _unhandled_input(_event: InputEvent) -> void:
	if _event is InputEventMouseMotion:
		camera_holder.rotate_y(-_event.relative.x * cam_res.sens)
		camera.rotate_x(-_event.relative.y * cam_res.sens)	
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-cam_res.down_look_limit), deg_to_rad(cam_res.up_look_limit))	

func _on_state_changed(from_state, to_state) -> void:
	#camera_player
	if to_state is CrouchingState:
		if camera_player.current_animation == CAMERA_CROUCH:
			camera_player.speed_scale *= -1
		else:
			camera_player.speed_scale = 1
			camera_player.play(CAMERA_CROUCH)
	elif from_state is CrouchingState:
		if camera_player.current_animation == CAMERA_CROUCH:
			camera_player.speed_scale *= -1
		else:
			camera_player.speed_scale = 1
			camera_player.play_backwards(CAMERA_CROUCH)
