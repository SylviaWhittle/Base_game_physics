extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Logger.info(self, 'hub ready')
	GameManager.scene_started()



func _on_Teleporter_teleport_player():
	GameManager.change_scene("res://Scenes/Arena1.tscn")
