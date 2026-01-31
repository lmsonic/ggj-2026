class_name Player extends CharacterBody2D
@onready var input_component: InputComponent = $InputComponent
@onready var movement_component: MovementComponent = $MovementComponent
@onready var health_component: HealthComponent = $HealthComponent

func _ready() -> void:
	health_component.dead.connect(on_death)

func on_death() -> void:
	get_tree().reload_current_scene()
	

func _physics_process(_delta: float) -> void:
	var input := input_component.fetch()
	movement_component.move(input)
