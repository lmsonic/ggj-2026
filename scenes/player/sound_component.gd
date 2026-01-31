class_name SoundComponent extends AudioStreamPlayer2D

@export var same_seek := false

func play_sound(s:AudioStream,fade:=0.0) -> void:
	if stream != s:
		var tween := create_tween()
		tween.tween_property(self,"volume_db",-20.0,fade)
		tween.tween_property(self,"volume_db",0.0,fade)
		stream = s
		await tween.finished
		play()

func stop_sound(fade:=0.0) -> void:
	stream = null
	var tween := create_tween()
	tween.tween_property(self,"volume_db",-20.0,fade)
	await tween.finished
	volume_db = 0.0
	stop()
