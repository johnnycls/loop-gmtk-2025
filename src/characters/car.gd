extends Area2D

@onready var color_rect: ColorRect = $ColorRect

var player_1_pos: Vector2 = Vector2(0,0)
var player_2_pos: Vector2 = Vector2(0,0)

var setting: Dictionary

func init(car_num: int, _setting: Dictionary) -> void:
	if car_num <= 1:
		global_position = player_1_pos
		add_to_group("player1_car")
	else:
		global_position = player_2_pos
		add_to_group("player2_car")
		
	if car_num == 0:
		color_rect.color = Config.COLORS["red"]
	elif car_num == 1:
		color_rect.color = Config.COLORS["orange"]
	elif car_num == 2:
		color_rect.color = Config.COLORS["blue"]
	elif car_num == 3:
		color_rect.color = Config.COLORS["green"]

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player2_car") && is_in_group("player1_car"):
		area.setting["hp"] -= max(0, setting["attack"]-area.setting["defense"])
		setting["hp"] -= max(0, area.setting["attack"]-setting["defense"])
		if area.setting["hp"] <= 0:
			area.queue_free()
		if setting["hp"] <= 0:
			queue_free()
