extends Tower

# just need in it
var can_attack = false
var preveus_speed_multiplayer = Data. speed_multiplayer
func _ready() -> void:
	Change_wait_time()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Look at first enemy and attacks it
	if enemys. size() > 0:
		$Top.look_at(enemys[0].global_position)
	
	# The it's no enemys, look straight 
	if enemys. size() == 0:
		$Top.rotation = 0
	
	# Able the CV collision if it can attack
	if enemys and can_attack and Data. speed_multiplayer != 0:
		$Top/Attack_range_horse_tower/CollisionShape2D. disabled = false
		can_attack = false
	
	# Attack couldown Dependence on Speed Multiplayer
	if preveus_speed_multiplayer != Data. speed_multiplayer:
		await $Attack_couldown.timeout
		await Change_wait_time()
		preveus_speed_multiplayer = Data. speed_multiplayer

func Change_wait_time():
	if Data. speed_multiplayer != 0:
		$Attack_couldown.wait_time = 1.2 / Data. speed_multiplayer
	else:
		while Data. speed_multiplayer == 0:
			await get_tree().create_timer(0.01).timeout

func _on_attack_couldown_timeout() -> void:
	# Can attack if timer goes 
	if can_attack == false:
		can_attack = true
