extends Node2D

var game_end = false
var moves = 0

var grid_size = 16

func _process(delta):
	$GameInfo/MovesLabel.text = 'Moves: ' + str(moves)
	if game_end == false:
		var spots = $Spots.get_child_count()
		for spot in $Spots.get_children():
			if spot.occupied:
				spots -= 1
				
		if spots == 0:
			$GameInfo/AcceptDialog.popup()
			game_end = true


func _on_AcceptDialog_confirmed():
	get_tree().reload_current_scene()
