extends Spatial

class_name LevelBase
var player = preload("res://Characters/Player.tscn")


func _ready() -> void:
	spawn_player() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func spawn_player()->void:
	var p = player.instance()
	p.transform.origin = $PlayerPosition.transform.origin
	add_child(p)
