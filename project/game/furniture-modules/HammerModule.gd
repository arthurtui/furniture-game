extends Module

var side : int
var done := false


func _ready():
	score_hit = Constants.SCORE_HAMMER


func set_side(s: String):
	side = Constants.SIDE_MAP[s]
	[$Input/InputLeft, $Input/InputRight][side].show()
	$AnimationPlayer.play(s)


func handle_input(event: InputEvent):
	var input_side : int
	if event.is_action_pressed("left"):
		input_side = Constants.LEFT
	elif event.is_action_pressed("right"):
		input_side = Constants.RIGHT
	elif event.is_action_pressed("up"):
		input_side = -1
	else:
		return
	
	if done:
		miss()
	else:
		if input_side == side:
			hit()
			done = true
		else:
			miss()


func deactivate():
	.deactivate()
	if not done:
		miss()
