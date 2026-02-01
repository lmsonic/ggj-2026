extends Node

@onready var player:Player:
	get():
		return get_tree().get_first_node_in_group("player")

func shake_camera(amount:float=0.3)->void:
	player.camera.shake.add_trauma(amount)
const CUTSCENE = preload("res://scenes/cutscene.tscn")

func play_cutscene(anim:String) -> void: 
	player.camera.play_cutscene(anim)
	

var unlocked_masks:Array[MaskChangeComponent.Mask]= [
	MaskChangeComponent.Mask.Default,	
	MaskChangeComponent.Mask.Willow,
	MaskChangeComponent.Mask.Cirkul,
	MaskChangeComponent.Mask.Hera,
	MaskChangeComponent.Mask.Wrath
]
