extends Control
@onready var start: Button = %Start
@onready var quit: Button = %Quit


func _on_start_pressed() -> void:
	GameManager.change_scene("res://levels/hall.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
