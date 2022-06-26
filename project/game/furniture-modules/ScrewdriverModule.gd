extends Module

var side : int
var last_side := -1


func set_side(s: String):
	score_hit = Constants.SCORE_SCREWDRIVER
	side = Constants.SIDE_MAP[s]
	[$Input/Left, $Input/Right][side].show()
	$AnimationPlayer.play(s)


func handle_input(event: InputEvent):
	var input_side : int
	if event.is_action_pressed("up", false):
		input_side = Constants.UP
	elif event.is_action_pressed("left", false):
		input_side = Constants.LEFT
	elif event.is_action_pressed("right", false):
		input_side = Constants.RIGHT
	
	if not input_side in [Constants.UP, side]:
		miss()
	elif input_side == last_side:
		miss()
	else:
		last_side = input_side
		hit()


func deactivate():
	.deactivate()
	if last_side == -1:
		miss()


func begin_input_scroll(speed: float):
	.begin_input_scroll(speed)
	set_process(true)


func stop_input_scroll():
	set_process(false)
