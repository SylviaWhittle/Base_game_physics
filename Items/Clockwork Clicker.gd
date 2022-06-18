extends Button

onready var item_name = "Clockwork Clicker"

func _ready():
	$ClickTimer.stop()

func _process(delta):
	# Update name
	text = name + ": " + str(int($Cooldown.time_left))

func _on_ClickTimer_timeout():
	# Add clicks
	get_node("/root/MainScene").add_clicks(1)

func _on_Cooldown_timeout():
	# Stop the clockwork clicker
	$ClickTimer.stop()

func _on_Clockwork_Clicker_pressed():
	# Start the clockwork clicker
	$ClickTimer.start()
	$Cooldown.start()
