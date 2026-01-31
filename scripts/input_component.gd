class_name InputComponent extends Node

func fetch() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
