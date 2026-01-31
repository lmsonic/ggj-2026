class_name DamageArea extends Node2D
@onready var lifetime_timer: Timer = $LifetimeTimer

@onready var damaging_component: DamagingComponent = $DamagingComponent
@onready var area: Area2D = $Area2D
@onready var shape: CollisionShape2D = $Area2D/CollisionShape2D

func on_player_entered(body: Node2D) -> void:
	var player:= body as Player
	if player!=null:
		damaging_component.damage(player.health_component)

func _ready() -> void:
	lifetime_timer.timeout.connect(die)

func die() -> void:
	queue_free()

func spawn(damage := 1, radius := -1, lifetime:= -1) -> void:
	damaging_component.damage_value = damage
	if lifetime >= 0:
		lifetime_timer.wait_time = lifetime
	if radius >= 0:
		if shape != null:
			var circle: CircleShape2D = shape.shape
			if circle != null:
				circle.radius = radius
