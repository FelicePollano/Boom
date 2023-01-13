extends Camera

export(bool) var disabled = false
export(float) var speed = 0.1 # Arbitrary number
export(float, 0, 1) var intensity = .2 # In 3D-space units

var initial_translation : Vector3
var sine_function = 0
var x = 0

func _ready():
	initial_translation = translation

func _process(delta):
	if (Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_S)) and disabled == false:
		x += speed * delta
		sine_function = sin(x)
		translation.y = lerp(translation.y, initial_translation.y + (sine_function * intensity), 0.1)
	else:
		translation.y = lerp(translation.y, initial_translation.y, 0.1)
