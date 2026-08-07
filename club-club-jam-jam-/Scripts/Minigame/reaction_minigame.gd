extends Node2D

var score:int = 0 
var combo = 0 

var bpm = 100
var song_position = 0.0
var song_position_in_beats = 0 
var last_spawned_beat = 0 
var sec_per_beat = 60 /bpm 

var spawn_1_beat = 0
var spawn_2_beat = 1
var spawn_3_beat = 2
var spawn_4_beat = 3

var lane = 0 
var rand = 0 
var note = load("res://Scenes/Minigame/Note.tscn")
var instance

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func increment_score(num:int):
	if num > 0:
		combo += 1
	else:
		combo = 0 
		 
	
	score += num * combo 
	$Score.text = str(score)	
