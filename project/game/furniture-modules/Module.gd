extends Node2D
class_name Module

signal screen_exited

onready var visibility_notifier = $VisibilityNotifier2D

export(int) var blocks_height := 1;

const BLOCK_SIZE := 64


func set_side(_side: String):
	pass


func hit():
	pass


func miss():
	pass


func get_size() -> Vector2:
	return Vector2(0, blocks_height * BLOCK_SIZE)


func is_on_screen() -> bool:
	return visibility_notifier.is_on_screen()


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("screen_exited")
