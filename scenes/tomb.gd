extends CharacterBody2D
@export var horizontal_offset := 32
@export var can_open := false:
	set(value):
		can_open = value
@onready var interactable_component: InteractableComponent = $InteractableComponent

func _ready() -> void:
	interactable_component.monitorable = can_open

func _on_interactable_component_interacted() -> void:
	var tween := create_tween()
	tween.tween_property(self,"global_position:x",global_position.x + horizontal_offset,0.5)
	interactable_component.queue_free()
