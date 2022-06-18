extends Area2D

var speed = 75
var damage = 1

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group('Player'):
		body.take_damage(damage)
	queue_free()
