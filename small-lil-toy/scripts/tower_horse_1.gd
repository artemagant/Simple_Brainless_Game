extends Tower


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if enemys. size() > 0:
		$Top.look_at(enemys[0].global_position)
		
	if enemys. size() == 0:
		$Top.rotation = 0
