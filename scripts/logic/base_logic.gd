class_name BaseLogic
extends Node

@export var logic_enabled := true


func _ready() -> void:
    if not logic_enabled:
        set_script(null)
