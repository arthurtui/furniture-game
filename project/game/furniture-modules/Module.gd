extends Node2D
class_name Module

signal screen_exited
signal scored(score)

onready var visibility_notifier = $VisibilityNotifier2D
onready var input_sprites = $Input
onready var hit_sfx = $HitSFX
onready var sprite = $Sprite

export(int) var blocks_height := 1;

const BLOCK_SIZE := 128

var beat_begin : int
var beat_end : int
var input_scroll_speed := .0
var score_hit : int
var score_miss := Constants.SCORE_MISS
var audio_played := false


func _ready():
	set_process(false)
	sprite.frame = [8, 9, 10][randi()%3]


func _process(delta):
	input_sprites.position.y -= input_scroll_speed * delta


func set_beat(beat: int):
	beat_begin = beat
	beat_end = beat + blocks_height - 1


func set_side(_side: String):
	pass


func handle_input(_event: InputEvent):
	pass


func deactivate():
	$AnimationPlayer.playback_speed = 1
	$AnimationPlayer.play("fadeout")
	stop_input_scroll()


func hit():
	emit_signal("scored", score_hit)
	if not audio_played:
		audio_played = true
		hit_sfx.play()


func miss():
	emit_signal("scored", score_miss)


func begin_input_scroll(speed: float):
	input_scroll_speed = speed


func stop_input_scroll():
	pass


func get_size() -> Vector2:
	return Vector2(0, blocks_height * BLOCK_SIZE)


func is_on_screen() -> bool:
	return visibility_notifier.is_on_screen()


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("screen_exited")
