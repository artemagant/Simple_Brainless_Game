extends Area2D


# idk wthitt, but I trust the guide guy
var direction: Vector2
var speed = 150
var damage = 1

@warning_ignore("unused_parameter")
func setup(pos: Vector2, dir: float, bullet_enum: Data. Bullet):
	position = pos
	direction = Vector2. DOWN. rotated(dir)
	rotation = dir

func _process(delta: float) -> void:
	position += direction * speed * delta * Data. speed_multiplayer

# Destroy the bullet, then it's reach the border
func _on_area_entered(area: Area2D) -> void:
	if area. name == "Border":
		queue_free()
