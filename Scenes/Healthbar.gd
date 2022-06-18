extends TextureProgress

var player = null

func _process(delta):
	player = GameManager.get_player()
	value = player.get_health()
