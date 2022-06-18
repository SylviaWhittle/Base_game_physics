extends Node2D

var difficulty: float = 1.00
var difficulty_scaling: float = 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	Logger.info(self, 'loaded Arena1')


func _process(delta):
	difficulty += difficulty_scaling * delta
	
	$GameHud/DifficultyLabel.text = str('difficulty: ') + str(stepify(difficulty, 0.01))
