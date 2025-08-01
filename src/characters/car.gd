extends Area2D

signal cycle

@onready var color_rect: ColorRect = $ColorRect
@onready var hp_bar: ProgressBar = $ProgressBar

var setting: Dictionary
var angle: float = 0.0
var radius: float = 450.0
var hp: float
var is_start: bool = true

func init(car_num: int, _setting: Dictionary) -> void:
	if car_num <= 1:
		angle = -PI/2
		add_to_group("player1_car")
	else:
		angle = PI/2
		add_to_group("player2_car")
	
	setting = _setting
	hp = setting["hp"]
		
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
		area.hp -= max(0, setting["attack"]-area.setting["defense"])
		hp -= max(0, area.setting["attack"]-setting["defense"])
		if area.hp <= 0:
			area.queue_free()
		if hp <= 0:
			queue_free()
		hp_bar.value = hp/setting["hp"]*100
		area.hp_bar.value = area.hp/area.setting["hp"]*100
	elif (area.is_in_group("goal1") and is_in_group("player1_car")) or (area.is_in_group("goal2") and is_in_group("player2_car")):
			if is_start:
				is_start = false
			else:
				cycle.emit()

func _process(delta: float) -> void:
	var angular_speed: float = setting["speed"] / radius
	if is_in_group("player1_car"):
		angle -= angular_speed * delta
	elif is_in_group("player2_car"):
		angle += angular_speed * delta
	
	var x: float = cos(angle) * radius
	var y: float = sin(angle) * radius
	position = Vector2(x, y)
