extends CanvasLayer

var current_ui: Control

@onready var bg: ColorRect = $ColorRect

func change_hud(ui: Control):
	if Global.is_node_valid(current_ui):
		current_ui.queue_free()
		current_ui = null
	add_child(ui)
	current_ui = ui

func show_bg():
	bg.show()
	
func hide_bg():
	bg.hide()
