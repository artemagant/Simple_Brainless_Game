extends Node
# idk wthitt, but I trust guide guy
enum Bullet {SIGNAL, FIRE, MORTAR_EXPLOSION}

# Varyebles, that I need in different spots, and something from this I will save
var wave = 1
var enemys = 0
var speed_multiplayer = 1
var speed_variation = 5

func _process(_delta: float) -> void:
	if speed_variation == 0:
		speed_multiplayer = 0.0
	elif speed_variation == 1:
		speed_multiplayer = 0.2
	elif speed_variation == 2:
		speed_multiplayer = 0.4
	elif speed_variation == 3:
		speed_multiplayer = 0.6
	elif speed_variation == 4:
		speed_multiplayer = 0.8
	elif speed_variation == 5:
		speed_multiplayer = 1.0
	elif speed_variation == 6:
		speed_multiplayer = 1.2
	elif speed_variation == 7:
		speed_multiplayer = 1.4
	elif speed_variation == 8:
		speed_multiplayer = 1.6
	elif speed_variation == 9:
		speed_multiplayer = 1.8
	elif speed_variation == 10:
		speed_multiplayer = 2.0
	else: 
		speed_multiplayer = 1.0

# Every wave content for levels
var wave_content_level_1 = {
	"wave_1": [1, 3.0, 1, 3.0, 1, 3.0, 1, 3.0, 1, 2.5, 1, 2.0, 1, 1.0, 1, 1.0],
	"wave_2": [1, 2.0, 2, 2.0, 1, 1.5, 2, 1.5, 1, 1.0, 2, 0.5, 2, 0.5, 1, 0.5, 1, 0.5]
}
