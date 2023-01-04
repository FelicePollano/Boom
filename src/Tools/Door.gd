extends Spatial

var full_open=false
var full_close=true
var opening=false
var closing=false
var speed=2

onready var gate = $Gate
onready var door_sound=$DoorSound
onready var red_led_1=$"door-right/Plate1/RedLed"
onready var red_led_2=$"door-right/Plate2/RedLed"
onready var green_led_1=$"door-right/Plate1/GreenLed"
onready var green_led_2=$"door-right/Plate2/GreenLed"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	full_close=true
	set_on(red_led_1,Color.red)
	set_on(red_led_2,Color.red)

func _process(delta: float) -> void:
	if (opening or closing) and not door_sound.playing:
		door_sound.play()

func _physics_process(delta: float) -> void:
	var up = Vector3.UP
	if opening:
		var velocity= up*speed*delta
		gate.transform.origin+=velocity
		if gate.transform.origin.y>=23:
			gate.transform.origin.y=23
			opening=false
			full_open=true
			$Timer.start()
			set_on(green_led_1,Color.green)
			set_on(green_led_2,Color.green)
			set_off(red_led_1)
			set_off(red_led_2)
	if closing:
		var velocity= -up*speed*delta
		gate.transform.origin+=velocity
		if gate.transform.origin.y<=9.692:
			gate.transform.origin.y=9.692
			closing=false	
			full_close=true
			set_on(red_led_1,Color.red)
			set_on(red_led_2,Color.red)
			set_off(green_led_1)
			set_off(green_led_2)
	pass

func set_on(m:MeshInstance, c:Color):
	m.get_active_material(0).emission_enabled=true
	m.get_active_material(0).emission=c
	
func set_off(m:MeshInstance):
	m.get_active_material(0).emission_enabled=false
	
func _button_pressed(body: Node) -> void:
	if body.get_groups().find("Player") != -1:
		if full_open:
			full_open=false
			closing=true
		if full_close:
			full_close=false
			opening=true
	


func _on_Timer_timeout() -> void:
	if full_open:
		full_open=false
		closing=true
