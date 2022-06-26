extends Control

onready var furniture : Furniture = $FurniturePosition/Furniture as Furniture

const MODULE_HEIGHTS = {
	"empty": 1,
	"driller": 1,
	"hammer": 1,
	"saw": 1,
	"screwdriver": 2
}
const OFFSCREEN_BEATS = 10

var beatmap
var module_stack : Array
var time := .0
var beat_time : float
var current_beat := 0

func _ready():
	var i = 0
	beatmap = load("res://game/beatmaps/test_beatmap.tres") as Beatmap
	beat_time = 60.0 / beatmap.bpm
	furniture.speed = Module.HEIGHT * beatmap.bpm / 60.0
	
	while i < beatmap.duration_beats:
		if i in beatmap.beats.keys():
			var module_data : Dictionary = beatmap.beats[i] as Dictionary
			module_data["beat"] = i
			module_stack.append(module_data)
			i += MODULE_HEIGHTS[module_data.type]
		else:
			module_stack.append({"beat": i, "type": "empty"})
			i += MODULE_HEIGHTS["empty"]
	
	for j in 10:
		var m = module_stack.pop_front()
		furniture.create_module(m)


func _process(delta):
	time += delta
	if time >= beat_time:
		time -= beat_time
		current_beat += 1
	
	if module_stack.size() and\
			current_beat + OFFSCREEN_BEATS >= module_stack.front().beat:
		furniture.create_module(module_stack.pop_front())
