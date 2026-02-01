extends CanvasLayer

var rect := ColorRect.new()
func _ready() -> void:
	layer = 1
	rect.set_anchors_preset(ColorRect.PRESET_FULL_RECT)
	rect.mouse_filter=Control.MOUSE_FILTER_IGNORE
	rect.color = Color(0.0,0.0,0.0,0.0)
	add_child(rect)

func fade_out(fade:=0.5) -> Tween:
	var tween := create_tween()
	tween.tween_property(rect,"color",Color.BLACK,fade)
	return tween

func fade_in(fade:=0.5) -> Tween:
	var tween := create_tween()
	tween.tween_property(rect,"color",Color(0.0,0.0,0.0,0.0),fade)
	return tween
