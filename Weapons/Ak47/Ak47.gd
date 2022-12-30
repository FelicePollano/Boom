extends Spatial

onready var sprite = $CanvasLayer/Control/WeaponAnim
onready var shot = $ShotNoise
signal fire;
var flash = preload("res://Weapons/Flash.tscn")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var can_fire = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Fire") && can_fire:
		sprite.play("Fire")
		add_child(flash.instance())
		shot.play()
		can_fire = false;
		emit_signal("fire")
	yield(sprite,"animation_finished") 
	sprite.play("Idle")
	yield(sprite,"animation_finished")
	can_fire=true
