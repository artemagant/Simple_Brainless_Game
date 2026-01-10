extends Area2D

var damage = 2.5
# it for the enemys, so they can detect the hit of this horse and then disabled attac collision
func disable_collision():
	call_deferred("disable_collision_deferred")
func disable_collision_deferred():
	$CollisionShape2D.disabled = true
