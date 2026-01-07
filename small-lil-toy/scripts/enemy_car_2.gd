extends Area2D

var speed = 25
var path_follow:PathFollow2D
var health = 8
var alive = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if alive:
		# Progress the enemy through the path 
		path_follow.progress += speed*delta*Data.speed_multiplayer
		# If it touches you will loose your hp
		if path_follow.progress_ratio >= 0.99:
			queue_free()
			Data. enemys -= 1
		# Change size and speed, if it goes vertical 
		if (path_follow.progress_ratio >= 0.3 and path_follow.progress_ratio <= 0.47) or (path_follow.progress_ratio >= 0.73 and path_follow.progress_ratio <= 0.88):
			speed = 13
			scale.x = 4.0
			scale.y = 2.5
		else:
			speed = 25
			scale.x = 2.5
			scale.y = 4.0

func setup(new_path_follow: PathFollow2D):
	# idk wthitt, but I trust the guide guy 
	path_follow = new_path_follow


func _on_area_entered(area: Area2D) -> void:
	# destroy the bullet, if it touch it
	if area. name. begins_with("Bullet_") or area. name == "Bullet"  or area. name. begins_with("@Area2D@"):
		area. queue_free()
		health -= area. damage
	# Disable horse attack, then it touch it
	if area. name == "Attack_range_horse_tower":
		health -= area. damage
		area. disable_collision()
	# The enemy is dyed, but it's followpath2d not. 
	if health <= 0:
		$AnimatedSprite2D.animation = "Boom"
		alive = false
		Data. enemys -= 1
		call_deferred("disable_collision")

func disable_collision():
	$CollisionShape2D.disabled = true


func _on_animated_sprite_2d_animation_looped() -> void:
	if $AnimatedSprite2D.animation == "Boom":
		queue_free()
