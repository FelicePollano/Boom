extends KinematicBody


onready var sprite = $AnimatedSprite3D
onready var player : KinematicBody = get_tree().get_nodes_in_group("Player")[0]
onready var ray : RayCast = $RayCast
onready var nav : NavigationAgent = $NavigationAgent
onready var scream : AudioStreamPlayer = $Scream
onready var gotcha : AudioStreamPlayer = $Gotcha
var speed = 5
var health = 3
var ray_len = 35
var following = false
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("idle")
	rng.randomize()
	ray_len = 20+rng.randi_range(0,20)
	
func damage(how_much)->void:
	health-=how_much
	if health<=0:
		set_physics_process(false)
		set_process(false)
		$CollisionShape.disabled=true
		sprite.play("die")
		scream.play()	
	else:
		if not following:
			following=true
			sprite.play("walk")
			gotcha.play()
	

func _physics_process(delta: float) -> void:
	if following:
		var next = nav.get_next_location()
		var direction = (next - transform.origin).normalized()
		var vel = direction * speed * delta
		move_and_collide(vel)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var dir = (player.transform.origin-transform.origin).normalized()*ray_len
	nav.set_target_location(player.transform.origin)
	dir.y=0
	ray.cast_to=dir
	
	if ray.is_colliding():
		var coll=ray.get_collider()
		if coll.is_in_group("Player") and not following:
			following=true
			sprite.play("walk")
			gotcha.play()
	pass
