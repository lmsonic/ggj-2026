class_name LightGreenBoss extends CharacterBody2D
const LIGHT_GREEN_WAVE = preload("res://scenes/light_green_wave.tscn")


@onready var arc_jump_component: ArcJumpComponent = $ArcJumpComponent

@export var jump_time := 1.5
@onready var jump_timer: Timer = $JumpTimer
@export var navigation_region: NavigationRegion2D

func _ready() -> void:
	assert(navigation_region != null, "navigation region not set")
	jump_timer.timeout.connect(arc_jump_component.jump)
	jump_timer.start(jump_time)

func end_jump() -> void:
	var wave :Node2D= LIGHT_GREEN_WAVE.instantiate()
	wave.global_position = global_position
	get_tree().root.add_child(wave)
	
	

func _physics_process(delta: float) -> void:
	if arc_jump_component.is_jumping:
		velocity = arc_jump_component.calculate_velocity(delta)
		move_and_slide()

		if arc_jump_component.is_jumping and arc_jump_component.calculate_distance() <= 100.0:
			arc_jump_component.is_jumping = false
			end_jump()
			jump_timer.start(jump_time)
