class_name HorizontalMovementLib


## Расчитывает изменение скорости тела в зависимости от напрвления, заданного управляющей машиной.
## Применяется замедление: при отсутствии ввода скорость уменьшается,
## при изменении скорости в противоположном направлении
## используется значение ускорения decceleration
static func move_with_decceleration(
    target: CharacterBody3D, horizontal_movement_store: HorizontalMovementStore, delta: float
):
    var real_velocity = horizontal_movement_store.currently_applied_movement
    var target_velocity = horizontal_movement_store.direction * horizontal_movement_store.max_velocity
    var velocity_difference = target_velocity - real_velocity
    var d_velocity_direction = velocity_difference.normalized()

    # Скорость изменится по направлению d_velocity_direction,
    # значит локально скорость имеет вид velocity = real_velocity + t * d_velocity_direction.
    # Производная |velocity| по t в точке t = 0 равна
    # 2 * (real_velocity.x * d_velocity_direction.x + real_velocity.y * d_velocity_direction.y)
    var derivative = real_velocity.x * d_velocity_direction.x + real_velocity.y * d_velocity_direction.y

    var a = horizontal_movement_store.acceleration if derivative >= 0 else horizontal_movement_store.decceleration

    var d_velocity = (d_velocity_direction * a * delta).limit_length(velocity_difference.length())
    var new_velocity = Vector2(real_velocity.x + d_velocity.x, real_velocity.y + d_velocity.y).limit_length(
        max(horizontal_movement_store.max_velocity, real_velocity.length())
    )

    target.velocity.x += new_velocity.x - real_velocity.x
    target.velocity.z += new_velocity.y - real_velocity.y
    horizontal_movement_store.currently_applied_movement = new_velocity


## Расчитывает изменение скорости тела в зависимости от напрвления, заданного управляющей машиной
## Замедление не применяется: при отсутствии ввода горизонтальная скорость не меняется,
## ускорение одинаковое во всех направлениях
static func move_without_decceleration(
    target: CharacterBody3D, horizontal_movement_store: HorizontalMovementStore, delta: float
):
    if not horizontal_movement_store.direction:
        return

    var real_velocity = horizontal_movement_store.currently_applied_movement
    var d_velocity_direction = horizontal_movement_store.direction

    var a = horizontal_movement_store.acceleration
    var d_velocity = d_velocity_direction * a * delta
    var new_velocity = Vector2(real_velocity.x + d_velocity.x, real_velocity.y + d_velocity.y).limit_length(
        max(horizontal_movement_store.max_velocity, real_velocity.length())
    )

    target.velocity.x += new_velocity.x - real_velocity.x
    target.velocity.z += new_velocity.y - real_velocity.y
    horizontal_movement_store.currently_applied_movement = new_velocity


## Обновляет компоненту currently_applied_movement при столкновении
static func handle_slided(
    horizontal_movement_store: HorizontalMovementStore,
    old_velocity_3d: Vector3,
    new_velocity_3d: Vector3,
):
    var old_velocity := Vector2(old_velocity_3d.x, old_velocity_3d.z)
    var new_velocity := Vector2(new_velocity_3d.x, new_velocity_3d.z)
    if new_velocity.is_zero_approx():
        horizontal_movement_store.currently_applied_movement = Vector2(0, 0)
        return

    if new_velocity.is_equal_approx(old_velocity):
        return

    # Идея в том, что если весь вектор скорости был повернут и сжат,
    # то и компонента currently_applied_movement была изменена так же

    # Тождественный поворот
    var rotation := 0.0 if old_velocity.is_zero_approx() else old_velocity.angle_to(new_velocity)
    var scale := 1.0 if old_velocity.is_zero_approx() else new_velocity.length() / old_velocity.length()
    # Вычисляем проекцию получившегося вектора на горизонтальную плоскость
    horizontal_movement_store.currently_applied_movement = (
        scale * horizontal_movement_store.currently_applied_movement.rotated(rotation)
    )
