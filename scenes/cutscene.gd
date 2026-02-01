@tool class_name Cutscene extends AnimationPlayer

@export_tool_button("create cutscenes") var create_cutscenes_button := create_cutscenes
@export_dir var cutscenes_dir:String
const HERA_DEATH = preload("res://assets/sfx/heraDeath.wav")
const HOLLOW_DEATH = preload("res://assets/sfx/hollowDeath.wav")
const CIRKUL_DEATH = preload("res://assets/sfx/cirkulDeath.wav")
const WILLOW_DEATH = preload("res://assets/sfx/willowDeath.wav")
const WRATH_DEATH = preload("res://assets/sfx/wrathDeath.wav")

@onready var sound_component: SoundComponent = $SoundComponent
@onready var texture_rect: TextureRect = $"../TextureRect"

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	texture_rect.hide()
	#play_cutscene("hera")
	animation_finished.connect(
		func (_name:String) -> void:
			texture_rect.hide()
	)
	pass


func play_cutscene(anim:String)-> void:
	if Engine.is_editor_hint():
		return
	texture_rect.show()
	play("cutscenes/"+anim)
	match anim:
		"cirkul":
			sound_component.play_sound(CIRKUL_DEATH)
		"hera":
			sound_component.play_sound(HERA_DEATH)
		"hollow":
			sound_component.play_sound(HOLLOW_DEATH)
		"willow":
			sound_component.play_sound(WILLOW_DEATH)
		"wrath":
			sound_component.play_sound(WRATH_DEATH)

func fetch_images() -> Dictionary:
	var dict : Dictionary ={}
	var dir := DirAccess.open(cutscenes_dir)
	if dir:
		dir.list_dir_begin()
		var file_name := dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
				var anim_name := file_name
				var anim_path := cutscenes_dir.path_join(anim_name)
				var inner_dir := DirAccess.open(anim_path)
				var images :Array[Texture2D]= []
				var files := inner_dir.get_files()
				for file in files:
					var path := anim_path.path_join(file)
					var res :Texture2D= ResourceLoader.load(path, "Texture2D")
					if res:
						images.push_back(res)
				if inner_dir: 
					inner_dir.list_dir_begin()
					var inner_file_name:= inner_dir.get_next()
					while inner_file_name != "":
						if not inner_dir.current_is_dir():
							print("Found file: " + inner_file_name)
							var img_path := anim_path.path_join(inner_file_name)
							print(img_path)
							#var img :CompressedTexture2D= load(img_path)
							#images.push_back(img)
						inner_file_name = inner_dir.get_next()
				dict[anim_name]=images
			file_name = dir.get_next()
		return dict
	else:
		print("An error occurred when trying to access the path.")
		return {}

func create_cutscenes() -> void:
	var dict := fetch_images()
	const fps := 10.0
	const spf := 1.0/fps
	var library := AnimationLibrary.new()
	for key:String in dict:
		var images :Array[Texture2D]= dict[key]
		var animation:= Animation.new()
		var idx := animation.add_track(Animation.TYPE_VALUE)
		animation.track_set_path(idx,"TextureRect:texture")
		animation.length = spf * images.size()
		for i in range(images.size()):
			var img := images[i]
			print(i * spf)
			animation.track_insert_key(idx,i * spf,img)
		library.add_animation(key, animation)
	remove_animation_library("cutscenes")
	add_animation_library("cutscenes",library)
