extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var color:Color=Color.white
onready var light:OmniLight = $OmniLight
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	light.light_color=color
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Timer_timeout() -> void:
	queue_free()
