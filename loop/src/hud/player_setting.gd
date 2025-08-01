extends MarginContainer

@onready var title: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var first_car: ColorRect = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/ColorRect
@onready var first_attack_slider: HSlider = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/HSlider
@onready var first_defense_slider: HSlider = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/HSlider
@onready var first_hp_slider: HSlider = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer3/HSlider
@onready var first_speed_slider: HSlider = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer4/HSlider
@onready var first_cost_label: Label = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Label
@onready var second_car: ColorRect = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ColorRect
@onready var second_attack_slider: HSlider = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer/HSlider
@onready var second_defense_slider: HSlider = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer2/HSlider
@onready var second_hp_slider: HSlider = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer3/HSlider
@onready var second_speed_slider: HSlider = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer4/HSlider
@onready var second_cost_label: Label = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Label

var player_num: int = 0
var player_setting: Array = [
	{
		"attack": Config.ATTRIBUTES["attack"]["basic_value"],
		"defense": Config.ATTRIBUTES["defense"]["basic_value"],
		"hp": Config.ATTRIBUTES["hp"]["basic_value"],
		"speed": Config.ATTRIBUTES["speed"]["basic_value"],
		"cost": 100,
	},
	{
		"attack": Config.ATTRIBUTES["attack"]["basic_value"],
		"defense": Config.ATTRIBUTES["defense"]["basic_value"],
		"hp": Config.ATTRIBUTES["hp"]["basic_value"],
		"speed": Config.ATTRIBUTES["speed"]["basic_value"],
		"cost": 100,
	},
]

func _ready() -> void:
	first_attack_slider.value_changed.connect(func(_val): _update_value())
	first_defense_slider.value_changed.connect(func(_val): _update_value())
	first_hp_slider.value_changed.connect(func(_val): _update_value())
	first_speed_slider.value_changed.connect(func(_val): _update_value())
	second_attack_slider.value_changed.connect(func(_val): _update_value())
	second_defense_slider.value_changed.connect(func(_val): _update_value())
	second_hp_slider.value_changed.connect(func(_val): _update_value())
	second_speed_slider.value_changed.connect(func(_val): _update_value())
	_update_value()

func _cal_cost(car_num: int) -> float:
	var cost: float = 0
	var setting = player_setting[car_num]
	cost += Config.ATTRIBUTES["attack"]["cost"].call((setting["attack"]-Config.ATTRIBUTES["attack"]["basic_value"])/Config.ATTRIBUTES["attack"]["increase_value"])
	cost += Config.ATTRIBUTES["defense"]["cost"].call((setting["defense"]-Config.ATTRIBUTES["defense"]["basic_value"])/Config.ATTRIBUTES["defense"]["increase_value"])
	cost += Config.ATTRIBUTES["hp"]["cost"].call((setting["hp"]-Config.ATTRIBUTES["hp"]["basic_value"])/Config.ATTRIBUTES["hp"]["increase_value"])
	cost += Config.ATTRIBUTES["speed"]["cost"].call((setting["speed"]-Config.ATTRIBUTES["speed"]["basic_value"])/Config.ATTRIBUTES["speed"]["increase_value"])
	return cost

func _update_value() -> void:
	player_setting[0]["attack"] = first_attack_slider.value
	player_setting[0]["defense"] = first_defense_slider.value
	player_setting[0]["hp"] = first_hp_slider.value
	player_setting[0]["speed"] = first_speed_slider.value
	player_setting[0]["cost"] = _cal_cost(0)
	first_cost_label.text = "Cost: $" + str(player_setting[0].cost)
	player_setting[1]["attack"] = second_attack_slider.value
	player_setting[1]["defense"] = second_defense_slider.value
	player_setting[1]["hp"] = second_hp_slider.value
	player_setting[1]["speed"] = second_speed_slider.value
	player_setting[1]["cost"] = _cal_cost(1)
	second_cost_label.text = "Cost: $" + str(player_setting[1].cost)

func set_player_num(_player_num: int) -> void:
	player_num = _player_num
	if player_num == 0:
		first_car.color = Config.COLORS.red
		second_car.color = Config.COLORS.orange
	elif player_num == 1:
		first_car.color = Config.COLORS.blue
		second_car.color = Config.COLORS.green
	title.text = "Player " + str(_player_num+1) + " Setting"

func _on_button_pressed() -> void:
	if player_num == 0:
		Main.player1_setting = player_setting
		Main.change_to_player_setting_page(1)
	elif player_num == 1:
		Main.player2_setting = player_setting
		Main.change_to_ready_page()
