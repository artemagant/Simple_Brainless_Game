extends Tower


var preveus_speed_multiplayer = Data. speed_multiplayer
# Explanation in the tower_horse_1.gd, but hear I don't understand half of the things, but I trust the guide guy

func _ready() -> void:
	Change_wait_time()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if enemys. size() > 0:
		var progressis: Array
		for enemy in enemys:
			progressis. append(enemy. progress)
		var new_progressis = progressis. duplicate()
		new_progressis. sort()
		new_progressis.reverse()
		var highest_index = progressis. find(new_progressis[0])
		if highest_index:
			$Top.look_at(enemys[highest_index].global_position)
		else:
			$Top.look_at(enemys[0].global_position)
		$Top.rotation += PI/2
		
	if enemys. size() == 0:
		$Top.rotation = 0
	
	if preveus_speed_multiplayer != Data. speed_multiplayer:
		await $Attack_couldown.timeout
		await Change_wait_time()
		preveus_speed_multiplayer = Data. speed_multiplayer

func Change_wait_time():
	if Data. speed_multiplayer != 0:
		$Attack_couldown.wait_time = 1.5 / Data. speed_multiplayer
	else:
		while Data. speed_multiplayer == 0:
			await get_tree().create_timer(0.005).timeout


func _on_attack_couldown_timeout() -> void:
	var direction = Vector2. DOWN. rotated($Top.rotation).normalized()
	if enemys and Data. speed_multiplayer:
		$Shoot.pitch_scale = randf_range(1.0, 3.0)
		$Shoot.play()
		sniper_shoot. emit(position + direction*-10, $Top.rotation-PI, Data. Bullet. SIGNAL)
