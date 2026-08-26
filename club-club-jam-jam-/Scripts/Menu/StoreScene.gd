extends CanvasLayer

func _ready() -> void:
	for button in get_tree().get_nodes_in_group("Button"):
		button.pressed.connect(on_button_pressed.bind(button))
		button.mouse_exited.connect(mouse_interaction.bind(button,"exited"))
		button.mouse_entered.connect(mouse_interaction.bind(button,"entered"))
		
	pass 
	
		

func on_button_pressed(button: Button) -> void:
	match button.name:
		"Play": 
			var _game: bool = get_tree().change_scene_to_file("res://Scenes/Menu/Main.tscn")
		"Cap":
			if(Global.player_shell != "Cap"):
				Global.player_shell = "Cap"
		
		"Soft":
			if(Global.shells_got.has("Soft")):
				if(Global.player_shell != "Soft"):
					Global.player_shell = "Soft"
			else: 
				if(buying_shell(2,Global.quantity_shells)):
					Global.player_shell = "Soft"
					Global.shells_got.append("Soft")
		
		"Cone":
			if(Global.shells_got.has("Cone")):
				if(Global.player_shell != "Cone"):
					Global.player_shell = "Cone"
			else: 
				if(buying_shell(3,Global.quantity_shells)):
					Global.player_shell = "Cone"
					Global.shells_got.append("Cone")


func buying_shell(value:int	, holding: int) -> bool:
	if holding >= value:
		holding -= value
		Global.quantity_shells = holding
		return true
	else:
		return false
					
func mouse_interaction(button: Button, state: String) -> void:
	match state:
		"exited":
			button.modulate.a = 1
		"entered":
			button.modulate.a = 0.5
	
