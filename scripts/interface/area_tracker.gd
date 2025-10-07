class_name AreaTracker
extends Area3D

@export var init_shape: Shape3D

var shape: Shape3D:
    get:
        return shape
    set(value):
        $CollisionShape3D.shape = value


func _enter_tree() -> void:
    shape = init_shape


func contains(body: Node3D):
    return $Stores/NodeStore.contains(body)
