extends Node2D


func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("Fire"):
		next_scene()
	
func next_scene():
	get_tree().change_scene("res://Levels/Level0.tscn")
