class_name PlaneCast
extends Node3D

@export var init_width: float
@export var init_density: float
@export var init_distance: float
@export var init_enabled: bool
@export_flags_3d_physics var init_collision_mask: int

var distance: float:
    get:
        return _distance
    set(value):
        _distance = value
        for child in get_children():
            if child is RayCast3D:
                child.target_position.y = _distance

var enable: bool:
    get:
        return _enabled
    set(value):
        _enabled = value
        for child in get_children():
            if child is RayCast3D:
                child.enabled = _enabled

var collision_mask: int:
    get:
        return _collison_mask
    set(value):
        _collison_mask = value
        for child in get_children():
            if child is RayCast3D:
                child.collision_mask = _collison_mask

var _distance: float
var _enabled: float
var _collison_mask: int

var _leading_ray: RayCast3D


func _init(width = 0.0, density = 0.0, distance = 0.0, enabled = false, collision_mask = 0) -> void:
    init_width = width
    init_density = density
    init_distance = distance
    init_enabled = enabled
    init_collision_mask = collision_mask


func _enter_tree() -> void:
    _distance = init_distance
    _enabled = init_enabled
    _collison_mask = init_collision_mask

    assert(init_density > 0, "density should be positive")
    assert(init_width > 0, "width should be positive")
    assert(distance > 0, "distance should be positive")

    var num_of_rays = max(ceil(init_width * init_density), 1)

    if num_of_rays == 1:
        var raycast := RayCast3D.new()
        raycast.target_position = Vector3(0, distance, 0)
        raycast.position = Vector3(0, 0, 0)
        raycast.enabled = _enabled
        raycast.hit_from_inside = true
        _leading_ray = raycast
        add_child(raycast)
    else:
        var raycast_position := -init_width / 2
        var gap: float = init_width / (num_of_rays - 1)

        for i in range(num_of_rays):
            var raycast := RayCast3D.new()
            raycast.target_position = Vector3(0, distance, 0)
            raycast.position = Vector3(raycast_position, 0, 0)
            raycast.enabled = _enabled
            raycast.hit_from_inside = true
            if i == floor(num_of_rays / 2):
                _leading_ray = raycast
            add_child(raycast)
            raycast_position += gap


func force_update():
    for child in get_children():
        if child is RayCast3D:
            child.force_raycast_update()


func is_colliding():
    for child in get_children():
        if child is RayCast3D:
            if child.is_colliding():
                return true
    return false


func get_collision_distance():
    var res := INF

    for child in get_children():
        if child is RayCast3D:
            if not child.is_colliding():
                continue

            if child.get_collision_normal().is_zero_approx():
                # origin внутри объекта столкновения
                return 0
            var length = (child.get_collision_point() - child.global_position).length()
            res = min(res, length)
    return res


func get_collision_normal():
    return _leading_ray.get_collision_normal()


func get_target_position():
    return _leading_ray.target_position
