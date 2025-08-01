extends MarginContainer

@onready var winner_label: Label = $PanelContainer/CenterContainer/VBoxContainer/Label

func set_winner(_winner: int) -> void:
	if _winner == 0:
		winner_label.text = "Draw"
	elif _winner == 1:
		winner_label.text = "Player 1 Win!"
	elif _winner == 2:
		winner_label.text = "Player 2 Win!"

func _on_button_pressed() -> void:
	Main.change_to_player_setting_page(0)
