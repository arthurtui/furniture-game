extends Control

onready var furniture : Furniture = $FurniturePosition/Furniture as Furniture

var beatmap : Beatmap
var data_stack : Array
var time := .0
var active_module : Module
var modules : Array

func _ready():
	var i := 0
	beatmap = preload("res://game/beatmaps/test_beatmap.tres") as Beatmap
	furniture.speed = Module.BLOCK_SIZE * beatmap.bpm / 60.0
	
	while i < beatmap.duration_beats:
		if i in beatmap.beats.keys():
			var module_data : Dictionary = beatmap.beats[i] as Dictionary
			module_data["beat"] = i
			module_data["y"] = -i * furniture.speed * 60 / beatmap.bpm 
			data_stack.append(module_data)
			i += Constants.MODULE_HEIGHTS[module_data.type]
		else:
			data_stack.append({"beat": i, "type": "empty", "y": (-i *\
					furniture.speed * 60 / beatmap.bpm)})
			i += Constants.MODULE_HEIGHTS["empty"]
	
	while data_stack.size():
		var module = stack_module()
		if module.global_position.y <= - module.get_size().y / 2:
			break
	
	set_process(true)


func _process(delta: float):
	time += delta
	
	build_furniture()
	update_active_module(delta)


func _unhandled_input(event):
	if active_module and (event.is_action("left") or event.is_action("right")):
		active_module.handle_input(event)
		get_tree().set_input_as_handled()


func build_furniture():
	if data_stack.size() and furniture.last_module().is_on_screen():
# warning-ignore:return_value_discarded
		stack_module()


func update_active_module(delta: float):
	if not modules.size():
		return
	
	if not active_module:
		var module : Module = modules.front() as Module
		if time >= module.beat_begin * 60 / beatmap.bpm - Constants.LENIENCY - delta:
			active_module = modules.pop_front()
	elif time >= active_module.beat_end * 60 / beatmap.bpm + Constants.LENIENCY:
		active_module.deactivate()
		active_module = null


func stack_module() -> Module:
	var data = data_stack.pop_front()
	var module =  furniture.create_module(data)
	if data.type != "empty":
		modules.append(module)
	return module
