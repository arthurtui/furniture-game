extends Node2D
class_name Furniture

const MODULE_SCENES = {
	"empty": preload("res://game/furniture-modules/Module.tscn"),
	"driller": preload("res://game/furniture-modules/DrillerModule.tscn"),
	"hammer": preload("res://game/furniture-modules/HammerModule.tscn"),
	"saw": preload("res://game/furniture-modules/SawModule.tscn"),
	"screwdriver": preload("res://game/furniture-modules/ScrewdriverModule.tscn")
}

var speed : float = 200


func _process(delta: float):
	for child in get_children():
		var module : Module = child
		module.position.y += speed * delta


func create_module(module_data: Dictionary):
	var module : Module = MODULE_SCENES[module_data.type].instance() as Module
	if get_children().size():
		var last : Module = get_children().back() as Module
		module.position.y = last.position.y - (Module.HEIGHT / 2.0) *\
				(last.blocks_height + module.blocks_height)
	if "side" in module_data.keys():
		module.set_side(module_data.side)
	add_child(module)
# warning-ignore:return_value_discarded
	module.connect("screen_exited", self, "_on_module_screen_exited", [module])


func last_module():
	return get_children().back()


func _on_module_screen_exited(module: Module):
	print(module, ": Goodbye cruel world")
	module.queue_free()
