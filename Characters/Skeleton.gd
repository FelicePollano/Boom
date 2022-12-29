extends KinematicBody

onready var agent : NavigationAgent = $NavigationAgent
onready var player : Node = get_tree().get_nodes_in_group("Player")[0]

var speed = 7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	agent.set_target_location(player.transform.origin)
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var next = agent.get_next_location()
	var vel = (next - transform.origin).normalized()*speed*delta
	move_and_collide(vel)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Timer_timeout() -> void:
	agent.set_target_location(player.transform.origin)
