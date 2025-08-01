extends HBoxContainer

signal btn_pressed(btn_num)

@onready var first_money_label: Label = $PanelContainer/VBoxContainer/Label
@onready var first_cycle_label: Label = $PanelContainer/VBoxContainer/Label2
@onready var second_money_label: Label = $PanelContainer2/VBoxContainer/Label
@onready var second_cycle_label: Label = $PanelContainer2/VBoxContainer/Label2
@onready var timer_label: Label = $Label
@onready var first_btn: TextureButton = $PanelContainer/VBoxContainer/HBoxContainer/TextureButton
@onready var second_btn: TextureButton = $PanelContainer/VBoxContainer/HBoxContainer/TextureButton2
@onready var third_btn: TextureButton = $PanelContainer2/VBoxContainer/HBoxContainer/TextureButton
@onready var forth_btn: TextureButton = $PanelContainer2/VBoxContainer/HBoxContainer/TextureButton2

func _ready() -> void:
	first_btn.pressed.connect(func(): btn_pressed.emit(0))
	second_btn.pressed.connect(func(): btn_pressed.emit(1))
	third_btn.pressed.connect(func(): btn_pressed.emit(2))
	forth_btn.pressed.connect(func(): btn_pressed.emit(3))

func update_timer_label(time: int) -> void:
	timer_label.text = str(time)

func update_first_money_label(money: float) -> void:
	first_money_label.text = "Money: " + str(money)

func update_first_cycle_label(cycle: int) -> void:
	first_cycle_label.text = "Cycle: " + str(cycle)

func update_second_money_label(money: float) -> void:
	second_money_label.text = "Money: " + str(money)

func update_second_cycle_label(cycle: int) -> void:
	second_cycle_label.text = "Cycle: " + str(cycle)

func set_btn_enabled(btn_num: int, enabled: bool) -> void:
	if btn_num == 0:
		first_btn.disabled = !enabled
	elif btn_num == 1:
		second_btn.disabled = !enabled
	elif btn_num == 2:
		third_btn.disabled = !enabled
	elif btn_num == 3:
		forth_btn.disabled = !enabled
