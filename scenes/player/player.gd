class_name Player extends CharacterBody2D
@onready var input_component: InputComponent = $InputComponent
@onready var movement_component: MovementComponent = $MovementComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var walk_sound_component: SoundComponent = $WalkSoundComponent
@onready var run_sound_component: SoundComponent = $RunSoundComponent
@onready var camera: PlayerCamera = $Camera2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@onready var run_sound_thresh := movement_component.max_speed + 10.0

func facing_vector() -> Vector2:
	match anim.animation:
		"right": return Vector2.RIGHT
		"left": return Vector2.LEFT
		"down": return Vector2.DOWN
		"up": return Vector2.UP
	return Vector2.DOWN
func _ready() -> void:
	health_component.dead.connect(on_death)
	health_component.hit.connect(hit_feedback)

const hit_color := Color("a62572")
func hit_feedback() -> void:
	var tween := create_tween()
	
	tween.tween_property(anim, "modulate", hit_color, 0.1)
	tween.tween_property(anim, "modulate", Color.WHITE, 0.4)
	tween.parallel()
	tween.tween_property(anim, "scale", Vector2(1.2, 1.2), 0.1)
	tween.tween_property(anim, "scale", Vector2.ONE, 0.05)


func on_death() -> void:
	await get_tree().physics_frame
	get_tree().reload_current_scene()
	
func _physics_process(delta: float) -> void:
	input_component.fetch()
	var input := input_component.input_vector
	if input == Vector2.ZERO:
		anim.stop()
		anim.frame = 1
	if absf(input.x) >= absf(input.y):
		if input.x > 0.0:
			anim.play("right")
		elif input.x < 0.0:
			anim.play("left")
	else:
		if input.y > 0.0:
			anim.play("down")
		elif input.y < 0.0:
			anim.play("up")
	
	movement_component.move(input, delta, input_component.shift_pressed)
	var speed2 := velocity.length_squared()
	if speed2 >= run_sound_thresh * run_sound_thresh:
		run_sound_component.play_sound()
		walk_sound_component.stop_sound()
	elif speed2 > 0.01:
		run_sound_component.stop_sound()
		walk_sound_component.play_sound()
	else:
		run_sound_component.stop_sound()
		walk_sound_component.stop_sound()
