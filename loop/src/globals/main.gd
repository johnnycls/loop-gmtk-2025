extends Node2D

@onready var hud = $Hud

var player_setting_scene = preload("res://src/hud/player_setting.tscn")
var ready_scene = preload("res://src/hud/ready.tscn")
var status_scene = preload("res://src/hud/status.tscn")
var game_scene = preload("res://src/game.tscn")
var result_scene = preload("res://src/hud/result.tscn")

var player1_setting: Array
var player2_setting: Array
var game

func change_to_player_setting_page(_player_num: int) -> void:
	var player_setting = player_setting_scene.instantiate()
	hud.change_hud(player_setting)
	player_setting.set_player_num(_player_num)
	
func change_to_ready_page() -> void:
	hud.change_hud(ready_scene.instantiate())
	
func change_to_status_page() -> void:
	hud.change_hud(status_scene.instantiate())
	
func change_to_result_page(_winner: int) -> void:
	var result_page = result_scene.instantiate()
	result_page.set_winner(_winner)
	hud.change_hud(result_page)

func _ready() -> void:
	change_to_player_setting_page(0)

func start_game() -> void:
	change_to_status_page()
	game = game_scene.instantiate()
	game.set_status_page(hud.current_ui)
	add_child(game)

func end_game(winner: int) -> void:
	if Global.is_node_valid(game):
		change_to_result_page(winner)
		game.queue_free()
		game = null
