class_name MaskChangeComponent extends Node
const CIRKUL = preload("res://assets/sprite_frames/cirkul.tres")
const DEFAULT_MASK = preload("res://assets/sprite_frames/default_mask.tres")
const HERA = preload("res://assets/sprite_frames/hera.tres")
const WILLOW = preload("res://assets/sprite_frames/willow.tres")
const WRATH = preload("res://assets/sprite_frames/wrath.tres")
const HOLLOW = preload("res://assets/sprite_frames/hollow.tres")

@export var anim: AnimatedSprite2D 
@export var health_component: HealthComponent
@export var movement_component: MovementComponent
@export var player: Player

enum Mask{
	Default = 0,
	Willow = 1,
	Cirkul = 2,
	Hera = 3,
	Wrath = 4,
	Hollow = 5,
}

@onready var hp_default := health_component.max_health
@onready var movement_default := movement_component.max_speed
@onready var intimidation_default := player.intimidation


@export var willow_bonus_hp := 2
@export var willow_intimidation := 0.8

@export var hera_max_speed_multiplier := 0.9
@export var hera_sprint_multiplier := 2.0

@export var cirkul_max_speed_multiplier := 1.4
@export var cirkul_hp_debuff := 1

@export var wrath_intimidation := 1.2


func update_stats(mask:Mask) -> void:
	match mask:
		Mask.Default :
			health_component.max_health = hp_default
			movement_component.max_speed = movement_default
			player.intimidation = intimidation_default
			movement_component.sprint_enabled = false
		Mask.Willow : # + HP - INTIMIDATION
			health_component.max_health = hp_default + willow_bonus_hp
			movement_component.max_speed = movement_default
			player.intimidation = willow_intimidation
			movement_component.sprint_enabled = false
		Mask.Cirkul : # + SPD - HP
			health_component.max_health = hp_default - cirkul_hp_debuff
			movement_component.max_speed = movement_default * cirkul_max_speed_multiplier
			player.intimidation = intimidation_default
			movement_component.sprint_enabled = false
		Mask.Hera : # SPRINT - SPD
			health_component.max_health = hp_default
			movement_component.max_speed = movement_default  * hera_max_speed_multiplier
			player.intimidation = intimidation_default
			movement_component.sprint_enabled = true
			movement_component.sprint_multiplier = hera_sprint_multiplier
		Mask.Wrath : # +INTIMIDATION - SPRINT
			health_component.max_health = hp_default
			movement_component.max_speed = movement_default  * hera_max_speed_multiplier
			player.intimidation = wrath_intimidation
			movement_component.sprint_enabled = false
		Mask.Hollow:
			health_component.max_health = hp_default
			movement_component.max_speed = movement_default
			player.intimidation = intimidation_default
			movement_component.sprint_enabled = false
			



		

func mask_to_sprite_frames(mask:Mask) -> SpriteFrames:
	match mask:
		Mask.Default : return DEFAULT_MASK
		Mask.Willow : return WILLOW
		Mask.Cirkul : return CIRKUL
		Mask.Hera : return HERA
		Mask.Hollow: return HOLLOW
		Mask.Wrath: return WRATH
		_ : return DEFAULT_MASK

var current_mask := 0

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("next_mask"):
		var mask := (current_mask + 1) % Mask.size()
		change_mask(mask)
		current_mask = mask
	elif Input.is_action_just_pressed("prev_mask"):
		var mask := posmod(current_mask - 1, Mask.size())
		print(mask)
		change_mask(mask)
		current_mask = mask
	
	if Input.is_key_pressed(KEY_1):
		change_mask(Mask.Default)
	elif Input.is_key_pressed(KEY_2) :
		#and GameManager.unlocked_masks.has(Mask.Willow):
		change_mask(Mask.Willow)
	elif Input.is_key_pressed(KEY_3):
	 #and GameManager.unlocked_masks.has(Mask.Cirkul):
		change_mask(Mask.Cirkul)
	elif Input.is_key_pressed(KEY_4):
	 #and GameManager.unlocked_masks.has(Mask.Hera):
		change_mask(Mask.Hera)
	elif Input.is_key_pressed(KEY_5):
	 #and GameManager.unlocked_masks.has(Mask.Wrath):
		change_mask(Mask.Wrath)
	elif Input.is_key_pressed(KEY_6):
	 #and GameManager.unlocked_masks.has(Mask.Wrath):
		change_mask(Mask.Hollow)

func change_mask(mask:Mask) -> void:
	anim.sprite_frames = mask_to_sprite_frames(mask)
	update_stats(mask)
