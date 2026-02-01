class_name PlayerCamera extends Camera2D
@onready var shake: ShakeCameraComponent = $ShakeCameraComponent
@export var cutscene: Cutscene 


func play_cutscene(anim:String) -> void:
	cutscene.play_cutscene(anim)
	 
