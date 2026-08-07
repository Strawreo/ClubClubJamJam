extends Node

var player_shell:String = "Cap"
var quantity_shells:int = 0
var shells_got:Array = ["Cap"]

func _ready() -> void:
	load_game()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()

func save_game():
	var file = FileAccess.open("user://Scripts/SaveFile.txt",FileAccess.WRITE)
	if file:
		file.store_line(player_shell)
		file.store_line(str(quantity_shells))
		file.store_line(",".join(shells_got))
		
		file.close()

func load_game():
	if not FileAccess.file_exists("user://Scripts/SaveFile.txt"):
		save_game()
		return
	
	var file = FileAccess.open("user://Scripts/SaveFile.txt",FileAccess.READ)
	
	if file:
		player_shell = file.get_line()
		quantity_shells = file.get_line().to_int()
		
		var shells = file.get_line()
		if shells != "":
			shells_got = shells.split(",")
		else:
			shells_got = []
		file.close()
