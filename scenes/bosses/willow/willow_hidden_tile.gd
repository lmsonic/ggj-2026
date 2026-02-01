class_name WillowHiddenTile extends Sprite2D

@export var boss:WillowBoss
@onready var sound_component: SoundComponent = $SoundComponent
const CURTAINS = preload("res://assets/sfx/curtains.wav")

var willow_present := false:
	set(value):
		willow_present = value

func _on_interactable_component_interacted() -> void:
	if willow_present:
		boss.random_respawns.remove_child(self)
		queue_free()
		boss.respawn_random()
		sound_component.play_sound(CURTAINS)
		
