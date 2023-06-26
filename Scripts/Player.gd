extends KinematicBody2D

onready var ray = $RayCast2D

var grid_size = 16
var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

var directions = {
	0: 'ui_up',
	1: 'ui_down',
	2: 'ui_left',
	3: 'ui_right'
}

func _unhandled_input(event):
	for direction in inputs.keys():
		if event.is_action_pressed(direction):
			move(direction)
		if event.is_action_pressed("reset"):
			get_tree().reload_current_scene()

func move(direction):
	var game = get_parent()
	var vector_pos = inputs[direction] * grid_size
	
	ray.cast_to = vector_pos
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		position += vector_pos
		game.moves += 1
	else:
		var collider = ray.get_collider()
		if collider.is_in_group('box'):
			if collider.move(direction):
				position += vector_pos
				game.moves += 1


func _on_Button_pressed():
	var line_edit = get_parent().get_node("Algorithm/LineEdit")
	var number_of_steps = int(line_edit.text)
	
	var direction_list = get_parent().get_node("Algorithm/DirectionList")
	
	# Get the first selected items because the single selection mode
	var item_idx = direction_list.get_selected_items()[0]
	var direction = directions[item_idx]
	
	for i in number_of_steps:
		move(direction)
		yield(get_tree().create_timer(0.5), "timeout")
	
