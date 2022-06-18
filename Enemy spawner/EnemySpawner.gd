extends Node2D

var scene = null
var spawnradius = 200
const zombie = preload("res://Enemies/Zombie/Zombie.tscn")
const imp = preload("res://Enemies/Imp/Imp.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	scene = get_tree().get_current_scene()
	

func _process(delta):
	pass


func chance(x):
	var rand = rand_range(0, 1)
	if x > rand:
		return true
	else: return false

func _on_Timer_timeout():
	Logger.info(self, 'spawning enemy')
	$Timer.wait_time = 10 / scene.difficulty
	
	# Spawn an enemy
	var player = GameManager.get_player()
	var randx = rand_range(player.position.x - spawnradius, player.position.x + spawnradius)
	var randy = rand_range(player.position.y - spawnradius, player.position.y + spawnradius)
	var newEnemy
	if chance(0.5):
		newEnemy = zombie.instance()
	else: newEnemy = imp.instance()
	scene.add_child(newEnemy)
	newEnemy.position = Vector2(randx, randy)
