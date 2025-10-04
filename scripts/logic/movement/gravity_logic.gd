class_name GravityLogic

extends Node

@export var gravity_store: GravityStore
@export var target: CharacterBody3D


func _physics_process(delta: float) -> void:
    gravity_store.gravity = (
        gravity_store.free_fall_decceleration if target.velocity.y > 0 else gravity_store.free_fall_acceleration
    )
    target.velocity.y += gravity_store.gravity * delta
