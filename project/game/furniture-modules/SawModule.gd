extends Module

var last_side := -1


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
	if last_side == -1:
		miss()
