class_name InputComponent extends Node

var shift_pressed := false


func fetch() -> Vector2:
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	shift_pressed = Input.is_action_pressed("sprint")
	return input
