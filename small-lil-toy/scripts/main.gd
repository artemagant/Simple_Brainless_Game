extends Node2D

@onready var fade = $Fade
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade.visible = true
	await _fade(0.0)


# Create a fade effect 
func _fade(to_alfa):
	var tween = create_tween()
	tween. tween_property(fade, "modulate:a", to_alfa, 1.0)
