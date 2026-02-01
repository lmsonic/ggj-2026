class_name MaskChangeComponent extends Node
const CIRKUL = preload("res://assets/sprite_frames/cirkul.tres")
const DEFAULT_MASK = preload("res://assets/sprite_frames/default_mask.tres")
const HERA = preload("res://assets/sprite_frames/hera.tres")
const WILLOW = preload("res://assets/sprite_frames/willow.tres")
@export var anim: AnimatedSprite2D 

enum Mask{
	Default,
	Willow,
	Cirkul,
	Hera,
}



func mask_to_sprite_frames(mask:Mask) -> SpriteFrames:
	match mask:
		Mask.Default : return DEFAULT_MASK
		Mask.Willow : return WILLOW
		Mask.Cirkul : return CIRKUL
		Mask.Hera : return HERA
		_ : return DEFAULT_MASK

func change_mask(mask:Mask) -> void:
	anim.sprite_frames = mask_to_sprite_frames(mask)
