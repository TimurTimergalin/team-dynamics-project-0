extends Node

@export var target: CharacterBody3D
@export var horizontal_movement_store: HorizontalMovementStore

func _process(delta: float) -> void:
    var real_velocity = Vector2(target.velocity.x, target.velocity.z)

    var d_velocity = (horizontal_movement_store.direction * horizontal_movement_store.max_velocity - real_velocity).normalized() * horizontal_movement_store.acceleration * delta
    var new_velocity = Vector2(target.velocity.x + d_velocity.x, target.velocity.z + d_velocity.y)  # clamp?
    target.velocity.x = new_velocity.x
    target.velocity.z = new_velocity.y