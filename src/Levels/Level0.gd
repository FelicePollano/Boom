extends LevelBase

var teleporter = preload("res://Tools/Teleporter.tscn")
var how_many=3
var victory=false
var teleporter_spawned = false
onready var teleporter_position:Position3D = $TeleporterPosition


func _on_Timer_timeout() -> void:
	if how_many > 0:
		how_many-=1
		spawn_enemies()
		


func _process(delta: float) -> void:
	._process(delta)
	var dead=0
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if enemy.health<=0:
			dead+=1
	if dead>=12 and not victory: # 3 initials + 3*3 enemies in this level
		victory=true
		$AudioStreamPlayer.stream=load("res://Music/boom_quiet.mp3")
		$AudioStreamPlayer.play()
	
	if victory and not teleporter_spawned and (player_instance.transform.origin-teleporter_position.transform.origin).length_squared()>2000:
		teleporter_spawned=true
		spawn_teleporter()
		
func spawn_teleporter()->void:
	var t = teleporter.instance()
	t.transform.origin=teleporter_position.transform.origin
	t.dest_scene="res://Levels/Level1.tscn"
	add_child(t)
