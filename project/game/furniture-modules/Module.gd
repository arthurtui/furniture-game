extends Node2D
class_name Module

signal screen_exited

export(int) var blocks_height := 1;

const HEIGHT := 64


func set_side(side: String):
	pass


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("screen_exited")
