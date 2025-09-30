extends Node

class_name GravityLogic

@export var gravity_store: GravityStore
@export var target: CharacterBody3D


func _physics_process(delta: float) -> void:
	target.velocity.y += gravity_store.gravity * delta
