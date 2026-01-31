extends Node

@onready var player:Player:
	get():
		return get_tree().get_first_node_in_group("player")

func shake_camera(amount:float=0.3)->void:
	player.camera.shake.add_trauma(amount)

	
