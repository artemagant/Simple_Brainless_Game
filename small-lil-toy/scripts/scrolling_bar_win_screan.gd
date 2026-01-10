extends Node2D

var speed = 20
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.position.y -= speed * delta


func _on_speed_up_button_down() -> void:
	speed = 100


func _on_speed_up_button_up() -> void:
	speed = 20


func _on_border_area_entered(_area: Area2D) -> void:
	#get_tree().change_scene_to_file("res://Scenes/main.tscn")
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/menu.tscn")
