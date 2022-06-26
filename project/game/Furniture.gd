extends Node2D
class_name Furniture

const MODULE_SCENES = {
	"empty": preload("res://game/furniture-modules/Module.tscn"),
	"driller": preload("res://game/furniture-modules/DrillerModule.tscn"),
	"hammer": preload("res://game/furniture-modules/HammerModule.tscn"),
	"saw": preload("res://game/furniture-modules/SawModule.tscn"),
	"screwdriver": preload("res://game/furniture-modules/ScrewdriverModule.tscn")
}

var speed : float
var stack : Array


func _ready():
	set_process(true)


func _process(delta: float):
	position.y += speed * delta


func create_module(module_data: Dictionary) -> Module:
	var module : Module = MODULE_SCENES[module_data.type].instance() as Module
	module.position.y = module_data.y - (module.blocks_height - 1) *\
			Module.BLOCK_SIZE / 2.0
	if "side" in module_data.keys():
		module.set_side(module_data.side)
	add_child(module)
	stack.append(module)
# warning-ignore:return_value_discarded
	module.connect("screen_exited", self, "_on_module_screen_exited", [module])
	return module


func last_module() -> Module:
	return get_children().back() as Module


func _on_module_screen_exited(module: Module):
	module.queue_free()
