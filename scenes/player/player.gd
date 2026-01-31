class_name Player extends CharacterBody2D
@onready var input_component: InputComponent = $InputComponent
@onready var movement_component: MovementComponent = $MovementComponent
@onready var health_component: HealthComponent = $HealthComponent

@onready var sprite: Sprite2D = $Char


func _ready() -> void:
	health_component.dead.connect(on_death)
	health_component.hit.connect(hit_feedback)

const hit_color := Color("a62572")
func hit_feedback() -> void:
	var tween := create_tween()
	tween.tween_property(sprite,"modulate",hit_color,0.1)
	tween.tween_property(sprite,"modulate",Color.WHITE,0.4)
	pass

func on_death() -> void:
	get_tree().reload_current_scene()
	

func _physics_process(_delta: float) -> void:
	var input := input_component.fetch()
	movement_component.move(input)
