class_name Tower extends Node2D
# idk wthitt, but I trust the guide guy 
@warning_ignore("unused_signal")
signal shoot(pos: Vector2, dir: float, bullet_enum: Data. Bullet)
@warning_ignore("unused_signal")
signal sniper_shoot(pos: Vector2, dir: float, bullet_enum: Data. Bullet)

var enemys:Array

func _process(_delta: float) -> void:
	pass

func _on_enemy_detection_area_area_entered(area: Area2D) -> void:
	if area. name. begins_with("enemy_"):
		if area not in enemys:
			enemys. append(area)


func _on_enemy_detection_area_area_exited(area: Area2D) -> void:
	if area in enemys:
		enemys. erase(area)
