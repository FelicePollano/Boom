extends LevelBase

var how_many=3


func _on_Timer_timeout() -> void:
	if how_many > 0:
		how_many-=1
		spawn_enemies()
