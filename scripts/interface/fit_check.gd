class_name FitCheck
extends Node3D

enum Direction { UP, DOWN }

@export_flags_3d_physics var init_collision_mask := 1
@export var init_enabled := false
@export var init_distance: float
@export var init_width: float
@export var init_density: float

var collision_mask:
    get:
        return _collision_mask
    set(value):
        _collision_mask = value
        $UpCheck.collision_mask = _collision_mask
        $DownCheck.collision_mask = _collision_mask

var enabled:
    get:
        return _enabled
    set(value):
        _enabled = enabled
        $UpCheck.enabled = _enabled
        $DownCheck.enabled = _enabled

var distance: float:
    get:
        return _distance
    set(value):
        _distance = value
        $UpCheck.distance = _distance
        $DownCheck.distance = _distance

var _collision_mask: int
var _enabled: bool
var _distance: float

@onready var check_mapping = {Direction.UP: $UpCheck, Direction.DOWN: $DownCheck}


func _init(width = 0.0, density = 0.0, distance = 0.0, enabled = false, collision_mask = 0) -> void:
    init_width = width
    init_density = density
    init_distance = distance
    init_enabled = enabled
    init_collision_mask = collision_mask


func _enter_tree() -> void:
    _collision_mask = init_collision_mask
    _enabled = init_enabled
    _distance = init_distance

    for node in [$UpCheck, $DownCheck]:
        node.init_width = init_width
        node.init_density = init_density
        node.init_collision_mask = init_collision_mask
        node.init_enabled = init_enabled
        node.init_distance = init_distance


func force_update():
    $UpCheck.force_update()
    $DownCheck.force_update()


func fits() -> bool:
    var up_dist = $UpCheck.get_collision_distance()
    var down_dist = $DownCheck.get_collision_distance()

    return up_dist != 0 and down_dist != 0 and up_dist + down_dist >= distance


func get_collision_distance(dir: Direction):
    return check_mapping[dir].get_collision_distance()


func get_collision_normal(dir: Direction):
    return check_mapping[dir].get_collision_normal()


func get_target_position(dir: Direction):
    return check_mapping[dir].get_target_position()


func get_global_basis_by_dir(dir: Direction):
    return check_mapping[dir].global_basis
