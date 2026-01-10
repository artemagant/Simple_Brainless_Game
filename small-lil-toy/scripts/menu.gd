extends Node2D

@onready var play_button = $Play_Button/play
@onready var fade_rect = $Fade
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_rect.modulate.a = 1.0
	await fade(0.0)


# Change scene, then you press this button
func _on_play_pressed() -> void:
	await fade(1.0)
	get_tree().call_deferred("change_scene_to_file" , "res://Scenes/scrolling_bar.tscn")

# Create a fade effect 
func fade(to_alfa):
	var tween = create_tween()
	tween. tween_property(fade_rect, "modulate:a", to_alfa, 1.0)
	await tween. finished


func _on_button_pressed() -> void:
	Data. reset_game()
	await fade(1.0)
	get_tree().call_deferred("change_scene_to_file" , "res://Scenes/scrolling_bar.tscn")
	
