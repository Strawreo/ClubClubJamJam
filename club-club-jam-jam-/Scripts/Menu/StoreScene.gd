extends Control

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
		#"Cap":
		
		#"Soft":
		
		#"Cone":


func buying_shell(value:int	, holding: int) -> bool:
	if holding >= value:
		holding -= value
		return true
	else:
		return false
					
func mouse_interaction(button: Button, state: String) -> void:
	match state:
		"exited":
			button.modulate.a = 1
		"entered":
			button.modulate.a = 0.5
	
