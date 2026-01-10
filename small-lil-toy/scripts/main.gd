extends Node2D

@onready var fade = $Fade
var current_level = null
const LEVEL_1 = preload("res://Scenes/levels/level_1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Data. load_game()
	current_level = get_node_or_null("level_root")
	fade.visible = true
	await load_level()
	await _fade(0.0)

func _process(_delta: float) -> void:
	if Data. player_health <= 0:
		Data. player_health = 0
		Data. speed_variation = 0
		await _fade(1.0)
		current_level = get_node_or_null("level_root")
		if current_level:
			current_level.queue_free()
		await get_tree().create_timer(1.0).timeout
		Data. reset_game()
		get_tree().change_scene_to_file("res://Scenes/scrolling_bar_loose_screan.tscn")
	if Data. win:
		Data. win = false
		await _fade(1.0)
		Data. reset_game()
		get_tree().change_scene_to_file("res://Scenes/scrolling_bar_win_screan.tscn")

func load_level():
	if current_level:
		current_level.queue_free()
	current_level = LEVEL_1.instantiate()
	add_child(current_level)
	current_level.name = "level_root"
# Create a fade effect 
func _fade(to_alfa):
	var tween = create_tween()
	tween. tween_property(fade, "modulate:a", to_alfa, 1.0)
	await tween. finished
