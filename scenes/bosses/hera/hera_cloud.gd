extends Node2D
@export var cloud_offset_y := 50.0
@export var cloud_accel := 350.0
@export var cloud_speed := 300.0
var velocity := Vector2.ZERO
@onready var damaging_component: DamagingComponent = $DamagingComponent
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var lighting_timer: Timer = $LightingTimer
@onready var lighting_time:=1.0
@onready var distance_start_to_darken:=200.0
@onready var lighting_sprite: Node2D = $Lighting
@onready var area: Area2D = $Area2D
@onready var disable_lighting_timer: Timer = $DisableLightingTimer

func _ready() -> void:
	lighting_timer.timeout.connect(lighting)
	disable_lighting_timer.timeout.connect(disable_lighting)
	lighting_timer.start(randf_range(1.0,1.5)*  player.intimidation )
	lighting_sprite.hide()

func lighting()-> void:
	lighting_sprite.show()
	area.monitoring = true
	disable_lighting_timer.start(randf_range(1.0,1.5) *  player.intimidation )
	
func disable_lighting()-> void:
	lighting_sprite.hide()
	area.set_deferred("monitoring",false)
	lighting_timer.start(randf_range(1.0,1.5) * player.intimidation)

func _exit_tree() -> void:
	player.modulate = Color.WHITE

func _physics_process(delta: float) -> void:
	var dir := global_position.direction_to(player.global_position +  + Vector2.UP * cloud_offset_y)

	velocity = velocity.move_toward(dir * cloud_speed, cloud_accel * delta)
	global_position += velocity * delta
	var d := global_position.distance_to(player.global_position)
	if d < distance_start_to_darken:
		var t := d/distance_start_to_darken
		var color := Color.WHITE.darkened((1.0-t)*0.5)
		player.modulate = color


func on_player_entered(body: Node2D) -> void:
	var p:= body as Player
	if p!=null:
		damaging_component.damage(player.health_component)
		disable_lighting()
	var statue:= body as HeraStatue
	if statue !=null:
		statue.energize()		
