extends Node2D

@onready var play_button = $Panel/play
@onready var fade_rect = $Fade
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_rect.modulate.a = 1.0
	fade(0.0)


# Change the button play texture, if you press it
func _on_play_button_down() -> void:
	play_button.icon = load("res://art/fonts/Play_button_pressed.png")
func _on_play_button_up() -> void:
	play_button.icon = load("res://art/fonts/Play_button.png")
func _on_play_pressed() -> void:
	await fade(1.0)
	get_tree().call_deferred("change_scene_to_file" , "res://Scenes/main.tscn")

# Create a fade effect 
func fade(to_alfa):
	var tween = create_tween()
	tween. tween_property(fade_rect, "modulate:a", to_alfa, 1.0)
	await tween. finished
