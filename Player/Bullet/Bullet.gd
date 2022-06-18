extends Area2D

var speed = 750
var damage = 1
var force = 30

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group('Enemies'):
		body.take_damage(damage)
		body.push(rotation, force)
	queue_free()
