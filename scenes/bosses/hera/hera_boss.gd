class_name HeraBoss extends Node2D
@onready var cloud: Node2D = $Cloud

var statues := 0
@export var amplitude := 10.0
@export var frequency := 5.0
var angle := 0.0
@onready var hera_sprite: Sprite2D = $HeraSprite

func _physics_process(delta: float) -> void:
	angle += delta
	hera_sprite.position.y = sin(angle * frequency) * amplitude

func add_statue()-> void:
	statues += 1
	print(statues)
func remove_statue()-> void:
	statues -= 1
	print(statues)
	if statues <= 0:
		GameManager.play_cutscene("hera")
		cloud.queue_free()
