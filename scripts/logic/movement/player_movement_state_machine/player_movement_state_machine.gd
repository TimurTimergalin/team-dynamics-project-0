extends StateMachine

@export var move_and_slide_logic: CharacterBodyMoveAndSlideLogic

func _ready() -> void:
	move_and_slide_logic.slided.connect(func (old_velocity, collision): cur_state.slided(old_velocity, collision))
