class_name InteractingComponent extends Area2D

var interactables :Array[InteractableComponent]
@onready var interacted_feedback: Node2D = $InteractedFeedback

func _ready() -> void:
	interacted_feedback.hide()
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)
	
func on_area_entered(area:Area2D) -> void:
	var i := area as InteractableComponent
	if i != null:
		interacted_feedback.show()
		interactables.push_back(i)

func on_area_exited(area:Area2D) -> void:
	var i := area as InteractableComponent
	if i != null:
		interactables.erase(area)
		if interactables.is_empty():
			interacted_feedback.hide()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		for i in interactables:
			i.interacted.emit()
