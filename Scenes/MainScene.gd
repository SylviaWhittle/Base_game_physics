extends Node2D

onready var clicks = 0
onready var clicks_per_second_measured = 0
onready var clicks_this_interval = 0
onready var clicks_history = []


# Called when the node enters the scene tree for the first time.
func _ready():
	print(str(1/$CPSTimer.wait_time))
	for i in range(1/$CPSTimer.wait_time + 1):
		clicks_history.append(0);
		
func add_clicks(num):
	clicks += num;
	$ClickCounter.text = "klics: " + str(clicks);
	
	# Clicks per second 
	
	# Add clicks to number of clicks this interval
	clicks_this_interval += num

func _process(delta):
	pass


func _on_Button_pressed():
	add_clicks(1);


func _on_Timer_timeout():
	$ClickHistory.text = str(clicks_history)
	clicks_history.pop_front()
	clicks_history.append(clicks_this_interval)
	clicks_this_interval = 0
	# Calculate new clicks per second
	var sum = 0;
	for num in clicks_history:
		sum += num
	
	clicks_per_second_measured = sum
	$ClicksPerSecondCounter.text="clicks per second: " + str(clicks_per_second_measured)
	
	$Graph.addpoint(clicks_per_second_measured);
	$Graph.updategraph();
