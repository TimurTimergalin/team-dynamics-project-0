class_name NodeStore
extends Node

var nodes: Dictionary[Node, bool] = {}


func add(node: Node):
    if not is_instance_valid(node):
        return

    node.tree_exited.connect(remove, CONNECT_ONE_SHOT)

    nodes[node] = true


func remove(node: Node) -> bool:
    if node.tree_exited.is_connected(remove):
        node.tree_exited.disconnect(remove)
    return nodes.erase(node)


func contains(node: Node) -> bool:
    return node in nodes
