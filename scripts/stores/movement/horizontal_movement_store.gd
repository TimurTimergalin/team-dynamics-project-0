class_name HorizontalMovementStore

extends Node

var max_velocity: float
var acceleration: float
var decceleration: float

## Направление, в котором скорость тела пытается изминиться
var direction := Vector2(0, 0)

## Компонента скорости тела, поражденная управляющей машиной этого тела
## Например, для игрока это значение скорости от нажатия им клавиш WASD
var currently_applied_movement := Vector2(0, 0)
