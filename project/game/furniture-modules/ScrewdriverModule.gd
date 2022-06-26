extends Module

var side : int
var last_side := -1


func set_side(s: String):
	side = Constants.SIDE_MAP[s]


func handle_input(event: InputEvent):
	var input_side : int
	if event.is_action_pressed("up"):
		input_side = Constants.UP
	elif event.is_action_pressed("left"):
		input_side = Constants.LEFT
	elif event.is_action_pressed("right"):
		input_side = Constants.RIGHT
	
	if not input_side in [Constants.UP, side]:
		miss()
	elif input_side == last_side:
		miss()
	else:
		last_side = input_side
		hit()


func deactivate():
	if last_side == -1:
		miss()
