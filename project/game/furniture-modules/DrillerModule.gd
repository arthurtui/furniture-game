extends Module

enum {WAITING, HELD, DONE}

var side : int
var state := WAITING


func _ready():
	score_hit = Constants.SCORE_DRILL
	set_process(false)


func set_side(s: String):
	side = Constants.SIDE_MAP[s]
	[$Input/InputLeft, $Input/InputRight][side].show()


func handle_input(event: InputEvent):
	var input_side : int
	if event.is_action_pressed("left", state == HELD):
		input_side = Constants.LEFT
	elif event.is_action_pressed("right", state == HELD):
		input_side = Constants.RIGHT
	elif event.is_action_pressed("up"):
		miss()
		return
	elif event.is_action_released("left") and side == Constants.LEFT:
		state = DONE
		return
	elif event.is_action_released("right") and side == Constants.RIGHT:
		state = DONE
		return
	else:
		return
	
	match state:
		WAITING:
			if input_side == side:
				hit()
				state = HELD
		HELD:
			if input_side == side:
				hit()
			else:
				miss()
		DONE:
			miss()


func deactivate():
	.deactivate()
	if state == WAITING:
		miss()


func begin_input_scroll(speed: float):
	.begin_input_scroll(speed)
	set_process(true)


func stop_input_scroll():
	set_process(false)
