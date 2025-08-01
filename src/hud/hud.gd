extends CanvasLayer

var current_ui: Control

@onready var bg: ColorRect = $ColorRect
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var click_sound = preload("res://src/assets/sfx/click.ogg")

func change_hud(ui: Control):
	if Global.is_node_valid(current_ui):
		current_ui.queue_free()
		current_ui = null
	add_child(ui)
	current_ui = ui
	add_sound_to_ui(ui)
	
func add_sound_to_ui(ui: Control):
	if ui is BaseButton:
		ui.button_down.connect(func(): Global.play_sound(click_sound, audio))
	for child in ui.get_children(true):
		add_sound_to_ui(child)

func show_bg():
	bg.show()
	
func hide_bg():
	bg.hide()
