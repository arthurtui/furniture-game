extends Node2D
class_name Furniture

var speed : float = 200


func _process(delta: float):
	for child in get_children():
		var module : Module = child
		module.position.y += speed * delta


func create_module(scene: PackedScene):
	var module : Module = scene.instance() as Module
	if get_children().size():
		var last : Module = get_children().back() as Module
		module.position.y = last.position.y - (Module.HEIGHT / 2.0) *\
				(last.blocks_height + module.blocks_height)
	add_child(module)
# warning-ignore:return_value_discarded
	module.connect("screen_exited", self, "_on_module_screen_exited", [module])


func last_module():
	return get_children().back()


func _on_module_screen_exited(module: Module):
	print(module, ": Goodbye cruel world")
	module.queue_free()
