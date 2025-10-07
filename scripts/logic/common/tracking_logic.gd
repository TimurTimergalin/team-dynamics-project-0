class_name TrackingLogic
extends BaseLogic

@export var node_store: NodeStore


func _body_entered(body: Node3D):
    node_store.add(body)


func _body_exited(body: Node3D):
    node_store.remove(body)
