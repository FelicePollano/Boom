extends KinematicBody

var ak47 = preload("res://Weapons/Ak47/Ak47.tscn")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var speed = 20
var ang_speed =2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(ak47.instance())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var disp= Vector3(speed*delta,0,0)
	disp = disp.rotated(Vector3(0,1,0),rotation.y)
	if Input.is_key_pressed(KEY_W):
		move_and_collide(-disp)
	if Input.is_key_pressed(KEY_S):
		move_and_collide(disp)
	if Input.is_key_pressed(KEY_A):
		rotate_y(ang_speed*delta)
	if Input.is_key_pressed(KEY_D):
		rotate_y(-ang_speed*delta)
	pass
