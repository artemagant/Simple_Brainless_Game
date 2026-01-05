extends Area2D

var speed = 25
var path_follow:PathFollow2D
var health = 5
var alive = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if alive:
		path_follow.progress += speed*delta
		if path_follow.progress_ratio >= 0.99:
			queue_free()
		if (path_follow.progress_ratio >= 0.3 and path_follow.progress_ratio <= 0.47) or (path_follow.progress_ratio >= 0.73 and path_follow.progress_ratio <= 0.88):
			speed = 13
			scale.x = 4.0
			scale.y = 2.5
		else:
			speed = 25
			scale.x = 2.5
			scale.y = 4.0

func setup(new_path_follow: PathFollow2D):
	path_follow = new_path_follow


func _on_area_entered(bullet: Area2D) -> void:
	bullet. queue_free()
	health -= bullet. damage
	if health <= 0:
		$AnimatedSprite2D.animation = "Boom"
		alive = false
		call_deferred("disable_collision")

func disable_collision():
	$CollisionShape2D.disabled = true


func _on_animated_sprite_2d_animation_looped() -> void:
	if $AnimatedSprite2D.animation == "Boom":
		queue_free()
