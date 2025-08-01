extends Node

var car_scene = preload("res://src/characters/car.tscn")
var dispatch_sound = preload("res://src/assets/sfx/click.ogg")

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var time: int = 200
var status_page: Control

var player_1_money: float = 0
var player_1_cycle: int = 0
var player_2_money: float = 0
var player_2_cycle: int = 0

func _change_money(_player_num: int, _delta: float):
	if _player_num == 0:
		player_1_money += _delta
		status_page.set_btn_enabled(0, player_1_money >= Main.player1_setting[0]["cost"])
		status_page.set_btn_enabled(1, player_1_money >= Main.player1_setting[1]["cost"])
		status_page.update_first_money_label(player_1_money)
	elif _player_num == 1:
		player_2_money += _delta
		status_page.set_btn_enabled(2, player_2_money >= Main.player2_setting[0]["cost"])
		status_page.set_btn_enabled(3, player_2_money >= Main.player2_setting[1]["cost"])
		status_page.update_second_money_label(player_2_money)

func set_status_page(_status_page) -> void:
	status_page = _status_page
	status_page.btn_pressed.connect(dispatch)
	
func cycle(_player_num: int):
	if _player_num==0:
		player_1_cycle += 1
		status_page.update_first_cycle_label(player_1_cycle)
	elif _player_num==1:
		player_2_cycle += 1
		status_page.update_second_cycle_label(player_2_cycle)

func dispatch(num: int):
	var car = car_scene.instantiate()
	add_child(car)
	Global.play_sound(dispatch_sound, audio)
	if num == 0:
		_change_money(0, -Main.player1_setting[0]["cost"])
		car.init(num, Main.player1_setting[0])
		car.cycle.connect(func(): cycle(0))
	elif num == 1:
		_change_money(0, -Main.player1_setting[1]["cost"])
		car.init(num, Main.player1_setting[1])
		car.cycle.connect(func(): cycle(0))
	elif num == 2:
		_change_money(1, -Main.player2_setting[0]["cost"])
		car.init(num, Main.player2_setting[0])
		car.cycle.connect(func(): cycle(1))
	elif num == 3:
		_change_money(1, -Main.player2_setting[1]["cost"])
		car.init(num, Main.player2_setting[1])
		car.cycle.connect(func(): cycle(1))

func _on_timer_timeout() -> void:
	_change_money(0, 20)
	_change_money(1, 20)
	time -= 1
	status_page.update_timer_label(time)
	
	if time <= 0:
		if player_1_cycle > player_2_cycle:
			Main.end_game(1)
		elif player_2_cycle > player_1_cycle:
			Main.end_game(2)
		else:
			Main.end_game(0)
