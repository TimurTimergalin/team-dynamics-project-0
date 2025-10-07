class_name CollisionMovement


static func skip_stairs(
    old_velocity: Vector3,  # Скорость тела до столкновения
    target: CharacterBody3D,  # Тело
    last_collision: KinematicCollision3D,  # Последнее столкновение
    feet_area_detectors: FourDirectional,  # Четверка AreaTracker-ов
    stairs_fit_checks: FourDirectional,  # Четверка FitCheck-ов
    max_stair_angle: float,  # Какой кгол наклона считать ступенькой, а какой - рампой
    fit_checks_height: float  # На какой высоте относительно нижней точеи тела находятся FitCheck-и
) -> bool:  # Произошел ли skip или нет
    for dir in FourDirectional.all_directions():
        var area_tracker = feet_area_detectors.get_by_dir(dir) as AreaTracker
        # Ищем, с какой стороны столкнулись
        var collided := false

        for i in range(last_collision.get_collision_count()):
            var collider := last_collision.get_collider(i)
            if area_tracker.contains(collider):
                collided = true
                break
        if not collided:
            continue

        var fit_check = stairs_fit_checks.get_by_dir(dir) as FitCheck
        fit_check.force_update()

        # Если тело не поместится в новой зоне
        if not fit_check.fits():
            return false

        var collision_norm = fit_check.get_collision_normal(FitCheck.Direction.DOWN)
        var global_target_position = (
            fit_check.get_global_basis_by_dir(FitCheck.Direction.DOWN)
            * fit_check.get_target_position(FitCheck.Direction.DOWN)
        )
        var angle = collision_norm.angle_to(-global_target_position)

        # Если препятствие не ступенька, а рампа, то skip не работает
        if angle > max_stair_angle:
            return false

        var dy = fit_checks_height - fit_check.get_collision_distance(FitCheck.Direction.DOWN)

        if dy <= 1e-4:
            return false

        # По-хорошему, здесь нужно прибавлять dy, но это не работает(
        # И непонятно почему - гравитация?
        target.position.y += 10 * dy

        var flattened_velocity = Vector3(old_velocity.x, 0, old_velocity.z)
        target.position += flattened_velocity * 1e-3
        target.velocity = flattened_velocity
        target.move_and_slide()
        return true

    return false
