extends Area2D

var speed = 19
var path_follow:PathFollow2D
var health = 200
var alive = true
var earn = 40

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if alive:
		# Progress the enemy through the path 
		path_follow.progress += speed*delta*Data.speed_multiplayer
		# If it touches you will loose your hp
		if path_follow.progress_ratio >= 0.99:
			queue_free()
			Data. player_health -= 1
			Data. money += Data. money_multiplayer * earn / 2
		# Change size and speed, if it goes vertical 
		if (path_follow.progress_ratio >= 0.0713 and path_follow.progress_ratio <= 0.1548) or (path_follow.progress_ratio >= 0.2767 and path_follow.progress_ratio <= 0.3121) or (path_follow.progress_ratio >= 0.3933 and path_follow.progress_ratio <= 0.4288) or (path_follow.progress_ratio >= 0.5304 and path_follow.progress_ratio <= 0.5784) or (path_follow.progress_ratio >= 0.741 and path_follow.progress_ratio <= 0.812) or (path_follow.progress_ratio >= 0.9344 and path_follow.progress_ratio <= 0.97):
			speed = 10
			scale.x = 3
			scale.y = 4
		else:
			speed = 19
			scale.x = 1.8
			scale.y = 6.

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
		Data. money += Data. money_multiplayer * earn 
		
		call_deferred("disable_collision")

func disable_collision():
	$CollisionShape2D.disabled = true


func _on_animated_sprite_2d_animation_looped() -> void:
	if $AnimatedSprite2D.animation == "Boom":
		queue_free()
