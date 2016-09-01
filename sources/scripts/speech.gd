
extends Node2D

onready var label = get_node("label")
onready var speech_bubble = get_node("speech_bubble")

func _ready():
	label.set_scroll_active(false)
	deactivate()

func activate():
	show()

func deactivate():
	hide()

func clear_text():
	label.clear()

func set_text(text):
	label.clear()
	label.set_bbcode(text)