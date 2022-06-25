extends Control

onready var furniture : Furniture = $FurniturePosition/Furniture as Furniture

const MODULE_HEIGHTS = {
	"empty": 1,
	"driller": 1,
	"hammer": 1,
	"saw": 1,
	"screwdriver": 2
}
const MODULE_SCENES = {
	"empty": preload("res://game/furniture-modules/Module.tscn"),
	"driller": preload("res://game/furniture-modules/DrillerModule.tscn"),
	"hammer": preload("res://game/furniture-modules/HammerModule.tscn"),
	"saw": preload("res://game/furniture-modules/SawModule.tscn"),
	"screwdriver": preload("res://game/furniture-modules/ScrewdriverModule.tscn")
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
			module_stack.append({"beat": i, "type": beatmap.beats[i]})
			i += MODULE_HEIGHTS[beatmap.beats[i]]
		else:
			module_stack.append({"beat": i, "type": "empty"})
			i += MODULE_HEIGHTS["empty"]
	
	for j in 10:
		var m = module_stack.pop_front()
		furniture.create_module(MODULE_SCENES[m.type])


func _process(delta):
	time += delta
	if time >= beat_time:
		time -= beat_time
		current_beat += 1
	
	if module_stack.size() and\
			current_beat + OFFSCREEN_BEATS >= module_stack.front().beat:
		furniture.create_module(MODULE_SCENES[module_stack.pop_front().type])
