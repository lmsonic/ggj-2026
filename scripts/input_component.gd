class_name InputComponent extends Node

var shift_pressed := false
var input_vector := Vector2.ZERO

func fetch() -> void:
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	shift_pressed = Input.is_action_pressed("sprint")
