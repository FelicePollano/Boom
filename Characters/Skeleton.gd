extends KinematicBody

onready var agent : NavigationAgent = $NavigationAgent
onready var player : Node = get_tree().get_nodes_in_group("Player")[0]
onready var sprite : AnimatedSprite3D = $AnimatedSprite3D
onready var scream : AudioStreamPlayer = $Scream
onready var fire_sound : AudioStreamPlayer = $Fire
onready var raycast : RayCast =$ RayCast
var speed = 3
var health=3
var fire_distance=900
var firing=false

func damage(how_much)->void:
	health-=how_much
	if health<=0:
		set_physics_process(false)
		set_process(false)
		$CollisionShape.disabled=true
		sprite.play("die")
		scream.play()
		
		
		
	
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	agent.set_target_location(player.transform.origin)
	

func _physics_process(delta: float) -> void:
	var next = agent.get_next_location()
	var direction = (next - transform.origin).normalized()
	# always cast fire in player direction
	$RayCast.cast_to=(player.transform.origin-transform.origin).normalized()*100
	$RayCast.cast_to.y=3.0 #adjust height
	#print( "distance:%s"%(player.transform.origin - transform.origin).length_squared() )
	if (player.transform.origin - transform.origin).length_squared() < fire_distance && !firing:
		firing=true
		fire()
	
	var vel = direction*speed*delta
	# if old player position reached
	# reset target - very poor AI for this enemy
	if (next-transform.origin).length_squared()<.1:
		agent.set_target_location(player.transform.origin)
	move_and_collide(vel)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func fire()->void:
	var save=speed
	speed=0
	sprite.play("Fire")
	fire_sound.play()
	yield(sprite,"animation_finished") 
	if raycast.is_colliding():
		var hit = raycast.get_collider()
		if hit.is_in_group("Player"):
			hit.damage(10)
	if health>0:
		speed=save
		sprite.play("walk")
		yield(get_tree().create_timer(1), "timeout")
		firing=false
	


