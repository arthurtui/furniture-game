extends Node2D
class_name Module

signal screen_exited

onready var visibility_notifier = $VisibilityNotifier2D

export(int) var blocks_height := 1;

const BLOCK_SIZE := 64

var beat_begin : int
var beat_end : int


func set_beat(beat: int):
	beat_begin = beat
	beat_end = beat + blocks_height - 1


func set_side(_side: String):
	pass


func handle_input(_event: InputEvent):
	pass


func deactivate():
	pass


func hit():
	$OK.show()


func miss():
	$FAIL.show()


func get_size() -> Vector2:
	return Vector2(0, blocks_height * BLOCK_SIZE)


func is_on_screen() -> bool:
	return visibility_notifier.is_on_screen()


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("screen_exited")
