extends Module

enum {WAITING, HELD, DONE}

var side : int
var state := WAITING


func set_side(s: String):
	side = Constants.SIDE_MAP[s]


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
	if state == WAITING:
		miss()
