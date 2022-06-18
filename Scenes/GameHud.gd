extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Logger.info(self, 'gamehud loaded')

func showFPS():
	$FPSCounter.text = 'fps: ' + str(Engine.get_frames_per_second())

func _process(delta):
	showFPS()
