extends Node2D

var current_wave = 1
var monsters_alive = 0

func _ready():
	start_wave(current_wave)

func start_wave(wave_number):
	current_wave = wave_number
	var monsters_to_spawn = wave_number * 5  # 5 monsters per wave
	monsters_alive = monsters_to_spawn

	for i in range(monsters_to_spawn):
		spawn_mob()

func spawn_mob():
	var new_mob = preload("res://monster.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

	# Safely connect signal from mob
	new_mob.connect("monster_died", Callable(self, "_on_monster_died"))
func _on_monster_died():
	monsters_alive -= 1
	print("Monster died! Monsters left:", monsters_alive)

	if monsters_alive <= 0:
		print("Wave", current_wave, "cleared!")
		current_wave += 1
		start_wave(current_wave)

func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true
	
	
