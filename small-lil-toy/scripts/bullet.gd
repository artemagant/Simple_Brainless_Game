extends Area2D

var direction: Vector2
var speed = 150
var damage = 1

@warning_ignore("unused_parameter")
func setup(pos: Vector2, dir: float, bullet_enum: Data. Bullet):
	position = pos
	direction = Vector2. DOWN. rotated(dir)
	rotation = dir

func _process(delta: float) -> void:
	position += direction * speed * delta
