extends Control

onready var furniture : Furniture = $FurniturePosition/Furniture as Furniture

var beatmap
var module_stack : Array
var time := .0
var beat_time : float
var current_beat := 0

func _ready():
	var i = 0
	beatmap = load("res://game/beatmaps/test_beatmap.tres") as Beatmap
	beat_time = 60.0 / beatmap.bpm
	furniture.speed = Module.BLOCK_SIZE * beatmap.bpm / 60.0
	
	while i < beatmap.duration_beats:
		if i in beatmap.beats.keys():
			var module_data : Dictionary = beatmap.beats[i] as Dictionary
			module_data["beat"] = i
			module_data["y"] = -i * furniture.speed * 60 / beatmap.bpm 
			module_stack.append(module_data)
			i += Constants.MODULE_HEIGHTS[module_data.type]
		else:
			module_stack.append({"beat": i, "type": "empty", "y": (-i *\
					furniture.speed * 60 / beatmap.bpm)})
			i += Constants.MODULE_HEIGHTS["empty"]
	
	while module_stack.size():
		var module = furniture.create_module(module_stack.pop_front())
		if module.global_position.y <= - module.get_size().y / 2:
			break
	
	set_process(true)


func _process(delta):
	time += delta
	if time >= beat_time:
		time -= beat_time
		current_beat += 1
	
	if module_stack.size() and furniture.last_module().is_on_screen():
		var _module = furniture.create_module(module_stack.pop_front())
