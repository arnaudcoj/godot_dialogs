
extends Node

const DIALOG_END = 0xDEADBEEF

var dialog_speech_gd = preload("res://scripts/dialog_speech.gd")
var dialog_change_state_gd = preload("res://scripts/dialog_change_state.gd")

#really heavy but works. Should build a tool.
var dialogs = {
	level1 = {
		player = create_change_state_dialog([["player", states_enum.INTERACT_STATE], ["npc1", states_enum.INTERACT_STATE]], create_dialog("hey !", "player", create_dialog("oh !", "player", create_change_state_dialog([["player", states_enum.IDLE_STATE], ["npc1", states_enum.IDLE_STATE]])))),
		npc1 = create_change_state_dialog([["player", states_enum.INTERACT_STATE], ["npc1", states_enum.TALKING_STATE]], create_dialog("I'm a NPC!", "npc1", \
		create_change_state_dialog([["player", states_enum.TALKING_STATE], ["npc1", states_enum.INTERACT_STATE]], create_dialog("Really?", "player", \
		create_change_state_dialog([["player", states_enum.INTERACT_STATE], ["npc1", states_enum.TALKING_STATE]], create_dialog("I'm a NPC!", "npc1", \
		create_change_state_dialog([["player", states_enum.TALKING_STATE], ["npc1", states_enum.INTERACT_STATE]], create_dialog("You already said that.", "player", \
		create_change_state_dialog([["player", states_enum.INTERACT_STATE], ["npc1", states_enum.TALKING_STATE]], create_dialog("I'm a NPC!", "npc1", \
		create_change_state_dialog([["player", states_enum.TALKING_STATE], ["npc1", states_enum.INTERACT_STATE]], create_dialog("I think I'm gonna leave you now.", "player", \
		create_change_state_dialog([["player", states_enum.INTERACT_STATE], ["npc1", states_enum.TALKING_STATE]], create_dialog("I'm a NPC!", "npc1", \
		create_change_state_dialog([["player", states_enum.IDLE_STATE], ["npc1", states_enum.IDLE_STATE]]))))))))))))))), #Too much parenthesis
		npc2 = create_change_state_dialog([["player", states_enum.INTERACT_STATE], ["npc1", states_enum.INTERACT_STATE], ["npc2", states_enum.TALKING_STATE]], create_dialog("I'm a NPC!", "npc2",\
		create_change_state_dialog([["player", states_enum.TALKING_STATE], ["npc1", states_enum.INTERACT_STATE], ["npc2", states_enum.INTERACT_STATE]], create_dialog("Please no...", "player",\
		create_change_state_dialog([["player", states_enum.INTERACT_STATE], ["npc1", states_enum.TALKING_STATE], ["npc2", states_enum.INTERACT_STATE]], create_dialog("WHAT DID YOU SAY ??", "npc1",\
		create_dialog("I AM THE FIRST CLASS NPC", "npc1",\
		create_change_state_dialog([["player", states_enum.INTERACT_STATE], ["npc1", states_enum.INTERACT_STATE], ["npc2", states_enum.TALKING_STATE]], create_dialog("NO, IT'S ME!", "npc2",\
		create_change_state_dialog([["player", states_enum.TALKING_STATE], ["npc1", states_enum.INTERACT_STATE], ["npc2", states_enum.INTERACT_STATE]], create_dialog("I want to go home...", "player",\
		create_change_state_dialog([["player", states_enum.IDLE_STATE], ["npc1", states_enum.IDLE_STATE], ["npc2", states_enum.INTERACT_STATE]])))))))))))),
		npc3 = create_change_state_dialog([["player", states_enum.INTERACT_STATE], ["npc3", states_enum.TALKING_STATE]], create_dialog("My Cat's name is 'Mittens'", "npc3",\
		create_change_state_dialog([["player", states_enum.IDLE_STATE], ["npc3", states_enum.IDLE_STATE]])))
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