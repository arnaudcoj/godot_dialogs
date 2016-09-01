
extends Node

const DIALOG_END = 0xDEADBEEF

var dialog_speech_gd = preload("res://scripts/dialog_speech.gd")
var dialog_change_state_gd = preload("res://scripts/dialog_change_state.gd")

var dialogs = {
	level1 = {
		player = create_change_state_dialog([["player", states_enum.INTERACT_STATE], ["npc1", states_enum.INTERACT_STATE]], create_dialog("hey !", "player", create_dialog("oh !", "player", create_change_state_dialog([["player", states_enum.IDLE_STATE], ["npc1", states_enum.IDLE_STATE]])))),
		npc1 = create_change_state_dialog([["player", states_enum.INTERACT_STATE], ["npc1", states_enum.INTERACT_STATE]], create_dialog("derp i'ma npc", "npc1", create_dialog("i know", "player", create_change_state_dialog([["player", states_enum.IDLE_STATE], ["npc1", states_enum.IDLE_STATE]]))))
	}
}

func _ready():
	pass

func get_dialog(level, character):
	return dialogs[level][character]

func create_dialog(dialog, character, next = null):
	var dialog_node = dialog_speech_gd.new()
	dialog_node.dialog = dialog
	dialog_node.character = character
	dialog_node.next = next
	return dialog_node
	
func create_change_state_dialog(characters_states, next = null):
	var dialog_node = dialog_change_state_gd.new()
	dialog_node.characters_states = characters_states
	dialog_node.next = next
	return dialog_node