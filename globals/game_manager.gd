extends Node

@onready var player:Player:
	get():
		return get_tree().get_first_node_in_group("player")

func restart_scene() -> void:
	var tree := get_tree()
	if tree:
		var tween :Tween = Fade.fade_out()
		await tween.finished
		tree.reload_current_scene()
		
func change_scene(path:String) -> void:
	var tree := get_tree()
	if tree:
		var tween :Tween= Fade.fade_out()
		await tween.finished
		tree.change_scene_to_file(path)
		await tree.scene_changed
		Fade.fade_in()

func shake_camera(amount:float=0.3)->void:
	player.camera.shake.add_trauma(amount)

func play_cutscene(anim:String) -> void: 
	player.camera.play_cutscene(anim)
	

var unlocked_masks:Array[MaskChangeComponent.Mask]= [
	MaskChangeComponent.Mask.Default,	
	MaskChangeComponent.Mask.Willow,
	MaskChangeComponent.Mask.Cirkul,
	MaskChangeComponent.Mask.Hera,
	MaskChangeComponent.Mask.Wrath
]
