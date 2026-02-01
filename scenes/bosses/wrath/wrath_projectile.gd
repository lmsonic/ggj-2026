extends RigidBody2D

@onready var damaging_component: DamagingComponent = $DamagingComponent
@onready var delete_timer: Timer = $DeleteTimer
@onready var area: Area2D = $Area2D

func _ready() -> void:
	area.body_entered.connect(on_player_entered)
	delete_timer.timeout.connect(
		func()-> void:
			queue_free()
	)
@onready var polygon_2d: Polygon2D = $Polygon2D

func _physics_process(delta: float) -> void:
	polygon_2d.global_rotation = linear_velocity.angle()


func on_player_entered(body: Node) -> void:
	var player := body as Player
	if player!=null:
		damaging_component.damage(player.health_component)
		queue_free()
