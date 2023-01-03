extends Spatial

var full_open=false
var full_close=true
var opening=false
var closing=false
var speed=2

onready var gate = $Gate

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	full_close=true
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var up = Vector3.UP
	if opening:
		var velocity= up*speed*delta
		gate.transform.origin+=velocity
		if gate.transform.origin.y>=23:
			gate.transform.origin.y=23
			opening=false
			full_open=true
	if closing:
		var velocity= -up*speed*delta
		gate.transform.origin+=velocity
		if gate.transform.origin.y<=9.692:
			gate.transform.origin.y=9.692
			closing=false	
			full_close=true
	pass

func _button_pressed(body: Node) -> void:
	if body.get_groups().find("Player") != -1:
		if full_open:
			full_open=false
			closing=true
			print("closing")
		if full_close:
			full_close=false
			opening=true
			print("opening")
	
