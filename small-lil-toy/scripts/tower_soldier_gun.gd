extends Tower


var preveus_speed_multiplayer = Data. speed_multiplayer
# Explanation in the tower_horse_1.gd, but hear I don't understand half of the things, but I trust the guide guy

func _ready() -> void:
	Change_wait_time()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if enemys. size() > 0:
		$Top.look_at(enemys[0].global_position)
		
	if enemys. size() == 0:
		$Top.rotation = 0
	
	if preveus_speed_multiplayer != Data. speed_multiplayer:
		await $Attack_couldown.timeout
		await Change_wait_time()
		preveus_speed_multiplayer = Data. speed_multiplayer

func Change_wait_time():
	if Data. speed_multiplayer != 0:
		$Attack_couldown.wait_time = 0.5 / Data. speed_multiplayer
	else:
		while Data. speed_multiplayer == 0:
			await get_tree().create_timer(0.01).timeout


func _on_attack_couldown_timeout() -> void:
	var direction = Vector2. DOWN. rotated($Top.rotation).normalized()
	if enemys and Data. speed_multiplayer:
		shoot. emit(position + direction*-1.1, $Top.rotation-PI/2, Data. Bullet. SIGNAL)
