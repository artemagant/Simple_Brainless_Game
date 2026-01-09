extends Area2D


# idk wthitt, but I trust the guide guy
var direction: Vector2
var speed = 350
var damage = 8
func _ready() -> void:
	speed = min(350*Data. speed_variation, 600)
@warning_ignore("unused_parameter")
func setup(pos: Vector2, dir: float, bullet_enum: Data. Bullet):
	position = pos
	direction = Vector2. DOWN. rotated(dir)
	rotation = dir
var previous_speed = Data. speed_variation
func _process(delta: float) -> void:
	if previous_speed != Data. speed_variation:
		speed = min(350*Data. speed_variation, 700)
		previous_speed = Data. speed_variation
	position += direction * speed * delta * Data. speed_multiplayer

# Destroy the bullet, then it's reach the border
func _on_area_entered(area: Area2D) -> void:
	if area. name == "Border":
		queue_free()
