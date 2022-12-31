extends LevelBase

var how_many=3
var victory=false

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
	if dead>=9 and not victory: # 3*3 enemies in this level
		victory=true
		$AudioStreamPlayer.stream=load("res://Music/boom_quiet.mp3")
		$AudioStreamPlayer.play()
