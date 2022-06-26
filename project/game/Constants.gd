extends Node

enum {LEFT, RIGHT, UP}

const MODULE_HEIGHTS = {
	"empty": 1,
	"driller": 1,
	"hammer": 1,
	"saw": 1,
	"screwdriver": 3
}
const SCREEN_SIZE = Vector2(1920, 1080)
const LENIENCY = .1 #seconds
const SIDE_MAP = {"left": LEFT, "right": RIGHT}

const SCORE_MISS = -50
const SCORE_DRILL = 1
const SCORE_HAMMER = 50
const SCORE_SAW = 10
const SCORE_SCREWDRIVER = 10
