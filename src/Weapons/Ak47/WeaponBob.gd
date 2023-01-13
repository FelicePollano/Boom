extends CanvasLayer

export(bool) var disabled = false
export(float) var speed = 0.1 # Arbitrary number
export(float) var intensity_y = .1 # In pixels
export(float) var intensity_x = .1 # In pixels

var initial_offset : Vector2
# We're moving the weapon in both the X and Y directions at different speeds so we need
# to reflect this in sine_function and x
var sine_function : Vector2
var x : Vector2 = Vector2(0, 0)

func _ready():
	initial_offset = offset

func _process(delta):
	self.visible = get_parent().visible
	if (Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_S)) and disabled == false:
		x += Vector2(speed/2 * delta, speed * delta)
		sine_function = Vector2(sin(x.x), sin(x.y))
		offset.y = lerp(offset.y, initial_offset.y + (sine_function.y * intensity_y) + intensity_y, 0.05)
		offset.x = lerp(offset.x, initial_offset.y + (sine_function.x * intensity_x), 0.05)
	else:
		offset.y = lerp(offset.y, initial_offset.y, 0.05)
		offset.x = lerp(offset.x, initial_offset.x, 0.05)
		
