extends Node2D

var score:int = 0 
var combo = 0 

var bpm = 100
var song_position = 0.0
var song_position_in_beats = 0 
var last_spawned_beat = 0 
var sec_per_beat = 60 /bpm 

var spawn_1_beat = 1
var spawn_2_beat = 0
var spawn_3_beat = 0
var spawn_4_beat = 0

var lane = 0 
var rand = 0 
var note = load("res://Scenes/Minigame/Note.tscn")
var instance

func _ready() -> void:
	randomize()
	$Conductor.play_with_beat_offset(0)
	pass

func _process(delta: float) -> void:
	pass

func increment_score(num:int):
	if num > 0:
		combo += 1
	elif num == null:
		combo = 0
	else:
		combo = 0 
		 
	
	score += num * combo 
	$Score.text = str(score)	


func _on_conductor_beat(position) -> void:
	song_position_in_beats = position
	if song_position_in_beats <= 40:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	elif song_position_in_beats > 40 and song_position_in_beats <= 80:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	else:
		spawn_1_beat = randi_range(0,3)
		spawn_2_beat = randi_range(0,2)
		spawn_3_beat = randi_range(0,3)
		spawn_4_beat = randi_range(0,4)

func _on_conductor_measure_sig(position) -> void:
	if position == 1:
		_spawn_notes(spawn_1_beat)
	elif position == 2:
		_spawn_notes(spawn_2_beat)
	elif position == 3:
		_spawn_notes(spawn_3_beat)
	elif position == 4:
		_spawn_notes(spawn_4_beat)
	
func _spawn_notes(to_spawn):
	for i in range(to_spawn):
		var instance = note.instantiate()
		$NotesContainer.add_child(instance)
		instance.initialize()
		
		if i > 0:
			instance.position.x += 20 * i
