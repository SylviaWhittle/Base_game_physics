extends RigidBody2D

var fireball = preload("res://Enemies/Imp/Fireball.tscn")
var maxhp = 5
onready var hp = maxhp
var movespeed = 30
var attackdamage = 10
var player = null
var velocity = Vector2(0, 0)
var approach_distance = 200

# Pathfinding
var path : = PoolVector2Array() setget set_path
onready var nav_2d : Navigation2D = get_node("../Navigation2D")
onready var space_state = get_world_2d().direct_space_state

func _ready():
	mass = 1
	set_bounce(1)
	linear_damp = 1

func _process(delta):
	rotation_degrees = 0
	$Line2D.position = -position
	player = GameManager.get_player()

	var line_of_sight = false
	var result = space_state.intersect_ray(position, player.position, [self])
	if result:
		if result.collider.name == 'Player':
			line_of_sight = true
			$Line2D.points = PoolVector2Array()
	if line_of_sight:
		var direction = (player.position - position).angle()
		var distance = position.distance_to(player.position)
		if distance > approach_distance:
			velocity = Vector2(movespeed * cos(direction), movespeed * sin(direction)) * delta
#			move_and_collide(velocity)
			apply_impulse(Vector2.ZERO, velocity)
		else:
			if $Attack_Cooldown.time_left == 0:
				attack()
	else:
		# Update pathfinding path
		var rand = rand_range(0, 1)
		if rand > 0.995:
			$Line2D.global_position = Vector2.ZERO
			path = nav_2d.get_simple_path(global_position, player.global_position, false)
			$Line2D.points = path
		# Pathfinding
#		var move_distance : float = movespeed * delta 
		var move_distance : float = linear_velocity.length()
		move_along_path(move_distance, delta)


func move_along_path(distance : float, delta : float) -> void:
	var start_point : = position
	
	
#	if path.size() > 0:
#		while true:
#			var distance_to_next : = start_point.distance_to(path[0])
#			var distance_to_second_next : = start_point.distance_to(path[1])
#			if distance_to_second_next < distance_to_next:
#				path.remove(0)
#			else:
#				break
	
	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0:
#			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			var dir = (path[0] - position).angle()
			velocity = Vector2(movespeed * cos(dir), movespeed * sin(dir)) * delta
			
#			move_and_slide(velocity)
			apply_impulse(Vector2.ZERO, velocity)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)

func set_path(value : PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return
	set_process(true)

func take_damage(dam):
	hp -= dam
	if hp <= 0:
		die()

func die():
	queue_free()

func push(dir, force):
	apply_impulse(Vector2.ZERO, Vector2(cos(dir), sin(dir)) * force)

func attack(): 
	# Line of sight
	var result = space_state.intersect_ray(position, player.position, [self])
#	Logger.info(self, result)
	if result:
		if result.collider.name == 'Player':
			Logger.info(self, 'LOS PLAYER')
			# Throw fireball
			var new_fireball = fireball.instance()
			new_fireball.position = position + 30 * Vector2(1, 0).rotated((player.position - position).angle())
			new_fireball.rotation = (player.position - position).angle()
			get_tree().get_root().call_deferred('add_child', new_fireball)
			$Attack_Cooldown.start()


