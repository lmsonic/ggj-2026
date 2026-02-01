extends Control
@onready var start: Button = %Start
@onready var quit: Button = %Quit

const HALL = preload("res://levels/hall.tscn")

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(HALL)

func _on_quit_pressed() -> void:
	get_tree().quit()
