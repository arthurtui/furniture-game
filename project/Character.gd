extends Node2D
class_name Character

onready var animation_player = $AnimationPlayer


export(String) var nickname = "beto"


func _ready():
	animate("idle")


func set_animation_speed(speed: float):
	animation_player.playback_speed = speed


func animate(action: String):
	animation_player.play(nickname + "_" + action)
