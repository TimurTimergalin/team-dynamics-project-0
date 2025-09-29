extends Node

@export var target: CharacterBody3D
@export var horizontal_movement_store: HorizontalMovementStore

func _process(delta: float) -> void:
    var real_velocity = Vector2(target.velocity.x, target.velocity.z)

    var velocity_difference = horizontal_movement_store.direction * horizontal_movement_store.max_velocity - real_velocity
    var d_velocity_direction = velocity_difference.normalized()

    # Скорость изменится по направлению d_velocity_direction,
    # значит локально скорость имеет вид velocity = real_velocity + t * d_velocity_direction.
    # Производная |velocity| по t в точке t = 0 равна 2 * (real_velocity.x * d_velocity_direction.x + real_velocity.y * d_velocity_direction.y)
    var derivative = real_velocity.x + d_velocity_direction.x + real_velocity.y * d_velocity_direction.y

    var a = (
        horizontal_movement_store.acceleration
        if derivative >= 0
        else horizontal_movement_store.decceleration
    )


    var d_velocity = (d_velocity_direction * a * delta).limit_length(velocity_difference.length())
    var new_velocity = Vector2(target.velocity.x + d_velocity.x, target.velocity.z + d_velocity.y).limit_length(horizontal_movement_store.max_velocity)

    target.velocity.x = new_velocity.x
    target.velocity.z = new_velocity.y