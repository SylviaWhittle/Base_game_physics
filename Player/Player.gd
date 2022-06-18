extends RigidBody2D

var movespeed = 100
var health_max = 100
var attack_delay = 0.2

var motion = Vector2(0, 0)
onready var health = health_max
var direction_looking = 0
var bullet = preload('res://Player/Bullet/Bullet.tscn')

var thrust_vector = Vector2(0, 0)
var thrust_direction = 0
var thrust_force = 30
var max_speed = 100
var speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	mass = 2
	set_bounce(1)
	linear_damp = 3
	$Attack_Delay_Timer.wait_time = attack_delay

func _physics_process(delta):
	direction_looking = ((get_global_mouse_position() - position).angle())	
	
	# Motion
	motion = Vector2.ZERO
	if Input.is_action_pressed('ui_up'):
		motion.y -= 1
	if Input.is_action_pressed('ui_down'):
		motion.y += 1
	if Input.is_action_pressed('ui_left'):
		motion.x -= 1
	if Input.is_action_pressed('ui_right'):
		motion.x += 1
	
	if abs(motion.x) > 1: motion.x = sign(motion.x)
	if abs(motion.y) > 1: motion.y = sign(motion.y)
	
	thrust_vector = motion.normalized() * thrust_force

	thrust_direction = motion.angle()
	# if velocity in desired direction is not equal to the max velocity, apply thrust
	
	speed = linear_velocity.dot(Vector2(cos(thrust_direction), sin(thrust_direction)))
	if speed < max_speed:
		var proportion = speed / max_speed
		apply_impulse(Vector2.ZERO, thrust_vector * (1 - proportion))
	
	update()
	
	# Shooting
	if Input.is_action_pressed('ui_fire'):
		fire()

func _draw():
#	draw_line(Vector2.ZERO, position, Color(1, 1, 1), 1, true)
	draw_line(Vector2.ZERO, Vector2(linear_velocity.x, linear_velocity.y), Color(0.8, 0.4, 0.2), 1, true)
	draw_line(Vector2.ZERO, Vector2(cos(thrust_direction), sin(thrust_direction)) * max_speed, Color(0.8, 0.8, 0.8), 1, true)
	draw_line(Vector2.ZERO, Vector2(cos(thrust_direction), sin(thrust_direction)) * speed, Color(0.2, 1, 0.2), 1, true)

func fire():
	if $Attack_Delay_Timer.time_left == 0:
		# Create bullet
		var bullet_instance = bullet.instance()
		bullet_instance.position = get_global_position() + 30 * Vector2(1, 0).rotated(direction_looking)
		bullet_instance.rotation = direction_looking
		get_tree().get_root().call_deferred('add_child', bullet_instance)
		var pitch_variation = rand_range(0.5, 1)
		$gun_small.pitch_scale = pitch_variation
		$gun_small.play()
		$Attack_Delay_Timer.start()
		Logger.info(self, 'fire')

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()

func die():
	emit_signal("player_died")

func get_health():
	return health
