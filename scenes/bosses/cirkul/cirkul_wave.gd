extends Node2D
@export var wave_speed := 8.0
@export var wave_width:= 10.0
@export var wave_death_speed:= 6.0
var radius := 0.0
var width :=wave_width
@onready var area: Area2D = $Area2D
@onready var shape: CollisionShape2D = $Area2D/CollisionShape2D
@onready var damaging_component: DamagingComponent = $DamagingComponent

func _ready() -> void:
	area.body_entered.connect(on_player_entered)
	var circle_shape :CircleShape2D = shape.shape
	if circle_shape != null:
		circle_shape.radius = 0.01

func on_player_entered(body:Node2D) -> void:
	var player := body as Player
	if player!=null:
		damaging_component.damage(player.health_component)
		area.set_deferred("monitorable",false)
	
func _draw() -> void:
	draw_circle(Vector2.ZERO,radius,Color.LIGHT_GREEN,false,width)
	
func _process(delta: float) -> void:
	radius += wave_speed *delta
	width -= wave_death_speed*delta
	queue_redraw()
	if width < 0.01:
		queue_free()
	var circle_shape :CircleShape2D = shape.shape
	if circle_shape != null:
		circle_shape.radius = radius
