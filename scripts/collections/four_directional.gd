class_name FourDirectional
extends Node3D

enum Direction { FORWARD, RIGHT, BACKWARD, LEFT }


static func all_directions():
    return [Direction.FORWARD, Direction.RIGHT, Direction.BACKWARD, Direction.LEFT]


func get_by_dir(dir: Direction):
    match dir:
        Direction.FORWARD:
            return $Forward
        Direction.RIGHT:
            return $Right
        Direction.BACKWARD:
            return $Backward
        Direction.LEFT:
            return $Left
