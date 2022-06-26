extends Module

var last_side := -1


func _ready():
	score_hit = Constants.SCORE_SAW
	$AnimationPlayer.playback_speed = 2
	$AnimationPlayer.play("saw")
	set_process(false)


func handle_input(event: InputEvent):
	var input_side : int
	if event.is_action_pressed("up"):
		miss()
		return
	elif event.is_action_pressed("left"):
		input_side = Constants.LEFT
	elif event.is_action_pressed("right"):
		input_side = Constants.RIGHT
	
	if last_side != input_side:
		last_side = input_side
		hit()
	else:
		miss()


func deactivate():
	.deactivate()
	if last_side == -1:
		miss()


func begin_input_scroll(speed: float):
	.begin_input_scroll(speed)
	set_process(true)


func stop_input_scroll():
	set_process(false)
