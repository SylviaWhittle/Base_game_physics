extends Node2D
var player_scene = preload("res://Player/Player.tscn")
var player = null
var player_dead = true

func get_player():
	if player == null:
		return null
	else: return player

func player_die():
	Logger.info(self, 'player died')
	# Return to the main scene

func player_create():
	player = player_scene.instance()
	Logger.info(self, 'player created')

func change_scene(scene : String):
	get_tree().change_scene(scene)
	Logger.info(self, 'changing scene')
	Logger.info(self, 'exiting: ' + str(get_tree().get_current_scene().get_name()))

func scene_started():
	Logger.info(self, 'started scene: ' + str(get_tree().get_current_scene().get_name()))
	get_tree().get_root().add_child(player)
	Logger.info(self, 'added player')
	
