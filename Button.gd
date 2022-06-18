extends Node

onready var item = preload("res://Items/Clockwork Clicker.tscn")
onready var text = ""

func _ready():
	text = 'test'
func _on_Button_pressed():
	var scene = get_node("/root/MainScene")
	# Buy clockwork clicker
	if scene.clicks >= 1:
		scene.clicks -= 1
		var new_clockwork_clicker = load("res://Items/Clockwork Clicker.tscn").instance()
		var inventory = get_node("/root/MainScene/Inventory/ScrollContainer/VBoxContainer")
	#	var label = Label.new()
	#	label.add_child(new_clockwork_clicker)
		inventory.add_child(new_clockwork_clicker)
	
