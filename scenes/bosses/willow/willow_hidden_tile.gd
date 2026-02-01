class_name WillowHiddenTile extends Sprite2D

@export var boss:WillowBoss

var willow_present := false:
	set(value):
		willow_present = value
		#if value:
			#modulate = Color.MAGENTA
		#else:
			#modulate = Color.BLACK
			#
func _on_interactable_component_interacted() -> void:
	if willow_present:
		boss.random_respawns.remove_child(self)
		queue_free()
		boss.respawn_random()
