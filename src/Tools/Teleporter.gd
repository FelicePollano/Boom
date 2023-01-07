extends Spatial



onready var player : KinematicBody = get_tree().get_nodes_in_group("Player")[0]
var dest_scene : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player.transform.origin-transform.origin).length_squared()<20:
		player.set_process(false)
		if not $AudioStreamPlayer.playing:
			$AudioStreamPlayer.play()
		get_tree().change_scene(dest_scene)
		
