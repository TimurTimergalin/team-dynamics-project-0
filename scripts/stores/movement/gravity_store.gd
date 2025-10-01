extends Node

class_name GravityStore

@export var resource: Resource

var gravity: float
var free_fall_acceleration: float
var free_fall_decceleration: float
	
func _ready() -> void:
	free_fall_acceleration = resource.free_fall_acceleration
	free_fall_decceleration = resource.free_fall_decceleration
	gravity = free_fall_acceleration
