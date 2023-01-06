extends Spatial

class_name LevelBase
var player = preload("res://Characters/Player.tscn")
var skeleton = preload("res://Characters/Skeleton.tscn")
var scientist = preload("res://Characters/Scientist.tscn")
var player_instance

func _ready() -> void:
	spawn_player() # Replace with function body.
	spawn_enemies()
			

func spawn_enemies()-> void:
	for node in get_children():
		var n = node.name.find("Enemy")
		if n  == 0:
			var enemy = spawn_enemy(node.name.substr(n+5).rstrip("0123456789")) 
			enemy.transform.origin = node.transform.origin
			add_child(enemy)

func spawn_enemy(name:String)->KinematicBody:
	match name:
		"Skeleton":
			return skeleton.instance()
		"Scientist":
			return scientist.instance()
	return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func spawn_player()->void:
	player_instance = player.instance()
	player_instance.transform.origin = $PlayerPosition.transform.origin
	add_child(player_instance)
