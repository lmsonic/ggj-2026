extends Area2D

@export_file_path(".tscn") var scene_path:String 

func _on_body_entered(body: Node2D) -> void:
	if body is Player and !scene_path.is_empty():
		GameManager.change_scene(scene_path)
