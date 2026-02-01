class_name WrathProjectile extends RigidBody2D
const WRATH_PROJECTILE = preload("res://scenes/bosses/wrath/wrath_projectile.tscn")
@export var projectile_speed := 300.0
@export var projectile_force := 300.0
@onready var damaging_component: DamagingComponent = $DamagingComponent
@onready var delete_timer: Timer = $DeleteTimer
@onready var area: Area2D = $Area2D
@export var respawn_angle := 45.0
@export var respawn_projectiles := 2
var projectiles: Node2D 
var can_respawn := false


func _ready() -> void:
	contact_monitor = true
	max_contacts_reported=1
	area.body_entered.connect(on_player_entered)
	delete_timer.timeout.connect(
		func()-> void:
			queue_free()
	)
@onready var polygon_2d: Polygon2D = $Polygon2D

func _physics_process(delta: float) -> void:
	polygon_2d.global_rotation = linear_velocity.angle()
	
func spawn_projectiles(pos:Vector2,dir:Vector2) -> void:
	var angle := deg_to_rad(respawn_angle)/2.0
	var step := deg_to_rad(respawn_angle)/(respawn_projectiles-1)
	var from:= dir.rotated(-angle)
	for i in range(respawn_projectiles):
		var proj :WrathProjectile = WRATH_PROJECTILE.instantiate()
		var d := from.rotated(step * i)
		var vel := d * projectile_speed * 0.5
		proj.global_position = global_position
		proj.linear_velocity = vel
		proj.scale = Vector2(0.5,0.5)
		proj.projectiles = projectiles
		projectiles.add_child(proj)
	queue_free()
	
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for i in state.get_contact_count():
		var collider :TileMapLayer= state.get_contact_collider_object(i) as TileMapLayer
		if collider != null:
			var local_normal := state.get_contact_local_normal(i)
			var normal := collider.to_global(local_normal)
			if can_respawn:
				call_deferred("spawn_projectiles",global_position,normal)
			else:
				call_deferred("queue_free")

func on_player_entered(body: Node) -> void:
	var player := body as Player
	if player!=null:
		damaging_component.damage(player.health_component)
		player.velocity += global_transform.x * projectile_force
		queue_free()
