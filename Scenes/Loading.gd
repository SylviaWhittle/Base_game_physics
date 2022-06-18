extends Node2D

func _init():
	GameManager.player_create()
	
	
func _ready():
	# Change scene
	GameManager.change_scene("res://Scenes/Hub.tscn")
	

