class_name LightGreenBoss extends CharacterBody2D
@export var grass_map: TileMapLayer
@export var leaves_map: TileMapLayer
@onready var health_component: HealthComponent = $HealthComponent
const CIRKUL_WAVE = preload("res://scenes/bosses/cirkul/cirkul_wave.tscn")
@onready var music: AudioStreamPlayer = $"../AudioStreamPlayer"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var arc_jump_component: ArcJumpComponent = $ArcJumpComponent

@onready var player: Player = get_tree().get_first_node_in_group("player")

@export var jump_time := 1.5
@onready var jump_timer: Timer = $JumpTimer

func _ready() -> void:
	jump_timer.timeout.connect(arc_jump_component.jump)
	jump_timer.start(jump_time)
	assert(grass_map, "grass map not set")
	assert(leaves_map, "leaves map not set")
	health_component.hit.connect(on_hit)
	health_component.dead.connect(on_death)

@onready var original_color := sprite.modulate
func on_hit() -> void:
	var tween := create_tween()
	tween.tween_property(sprite,"modulate",Color.RED,0.2)
	tween.tween_property(sprite,"modulate",original_color,0.2)
	


func on_death() -> void:
	var tween := create_tween()
	tween.tween_property(music,"volume_db",-10.0,0.2)
	await tween.finished
	music.stop()
	GameManager.play_cutscene("cirkul")
	queue_free()

const EMPTY_SOLID_TILE := Vector2i(13, 0)

func get_cell_neighbours_grass( coords: Vector2i) -> Array[Vector2i]:
	return [
		coords,
		grass_map.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_TOP_SIDE),
		grass_map.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_RIGHT_SIDE),
		grass_map.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_LEFT_SIDE),
		grass_map.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE),
	]
	

func get_cell_neighbours_leaves(coords: Vector2i) -> Array[Vector2i]:
	return [
		coords,
		leaves_map.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_TOP_SIDE),
		leaves_map.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_TOP_RIGHT_CORNER),
		leaves_map.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_TOP_LEFT_CORNER),
		leaves_map.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_RIGHT_SIDE),
		leaves_map.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_LEFT_SIDE),
		leaves_map.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE),
		leaves_map.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER),
		leaves_map.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER),
	]
	

func erase_from_grass_map() -> bool:
	var local := grass_map.to_local(global_position)
	var map := grass_map.local_to_map(local)
	if grass_map.get_cell_source_id(map) != -1:
		var neighbours := get_cell_neighbours_grass(map)
		for n in neighbours:
			grass_map.set_cell(n, 1, EMPTY_SOLID_TILE)
		return true
	return false
		
func erase_from_leaves_map() -> bool:
	var local := leaves_map.to_local(global_position)
	var map := leaves_map.local_to_map(local)
	if leaves_map.get_cell_source_id(map) != -1:
		var neighbours := get_cell_neighbours_leaves(map)
		for n in neighbours:
			leaves_map.erase_cell(n)
		return true
	return false

func end_jump() -> void:
	var wave: Node2D = CIRKUL_WAVE.instantiate()
	wave.global_position = global_position
	get_tree().root.add_child(wave)
	GameManager.shake_camera()
	
	var local := grass_map.to_local(global_position)
	var map := grass_map.local_to_map(local)
	if grass_map.get_cell_atlas_coords(map) == EMPTY_SOLID_TILE:
		health_component.damage(1)
		
		
	
	if not erase_from_leaves_map():
		erase_from_grass_map()
	
	
func _physics_process(delta: float) -> void:
	if arc_jump_component.is_jumping:
		velocity = arc_jump_component.calculate_velocity(delta)
		move_and_slide()

		if arc_jump_component.calculate_distance() <= 100.0:
			arc_jump_component.is_jumping = false
			end_jump()
			jump_timer.start(jump_time* player.intimidation)
