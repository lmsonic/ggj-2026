class_name SoundComponent extends AudioStreamPlayer2D

func fade_sound_out_in(fade := 0.2) -> Tween:
	var tween := create_tween()
	tween.tween_property(self, "volume_db", -10.0, fade)
	tween.tween_property(self, "volume_db", 0.0, fade)
	return tween

func fade_sound_out(fade := 0.2) -> Tween:
	var tween := create_tween()
	tween.tween_property(self, "volume_db", -10.0, fade)
	return tween


func play_sound(s: AudioStream = null) -> void:
	if s == null:
		if not playing:
			fade_sound_out_in()
			play()
	elif stream != s:
		var tween := fade_sound_out_in()
		stream = s
		await tween.finished
		play()


func remove_sound() -> void:
	var tween := fade_sound_out()
	await tween.finished
	volume_db = 0.0
	stream = null
	stop()

func stop_sound() -> void:
	var tween := fade_sound_out()
	await tween.finished
	volume_db = 0.0
	stop()
