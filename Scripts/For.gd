extends Node2D

var repeat_time = 0
var grid_size = 16
onready var player_sprite = get_node("KinematicBody2D")


# Called when the node enters the scene tree for the first time.
func _ready():
	repeat_time = int(get_node("ForNumber").text)
	print("Repeat time: ", repeat_time)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	while repeat_time > 0:
		print("Repeat time: ", repeat_time)
		player_sprite.move_and_slide(Vector2.DOWN * grid_size)
		repeat_time -= 1
