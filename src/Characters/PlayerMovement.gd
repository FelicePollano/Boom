extends KinematicBody

var ak47 = preload("res://Weapons/Ak47/Ak47.tscn")
var flash = preload("res://Weapons/Flash.tscn")
var blood = preload("res://Weapons/BloodHit.tscn")
onready var ouch : AudioStreamPlayer = $Ouch
onready var raycast : RayCast =$RayCast
onready var health_label : Label = $CanvasLayer/Control/ColorRect/Label2
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export(int) var speed = 20
export(float) var ang_speed = 1.2
var health=100

var current_weapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_weapon = ak47.instance()
	add_child(current_weapon)
	current_weapon.connect("fire",self,"on_fire")


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

	
func on_fire()->void:
	if raycast.is_colliding():
		var hit = raycast.get_collider()
		if hit.is_in_group("Enemy"):
			hit.damage(1)
			var pt = raycast.get_collision_point()
			var b = blood.instance()
			b.transform.origin=pt;
			b.emitting=true
			get_parent().add_child(b)	
	
func damage(amount)->void:
	health-=amount
	health_label.text = "%s"%health
	if health <= 50:
		health_label.add_color_override("font_color",Color.darkred)
	else:
		health_label.add_color_override("font_color",Color.white)
	var f=flash.instance()
	f.color=Color.darkred
	add_child(f)
	ouch.play()
	if health<=0:
		die()
	pass

func die()->void:
	$Camera.disabled = true
	current_weapon.visible = false
	$CollisionShape.disabled=true
	set_physics_process(false)
	set_process(false)
	$Die.play()
	# Animate falling down
	$Tween.interpolate_property(
		self,
		"translation:y",
		translation.y,
		translation.y - 5,
		1.0,
		Tween.TRANS_LINEAR
	)
	$Tween.start()
