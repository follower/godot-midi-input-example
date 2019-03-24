extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.open_midi_inputs()

	print(OS.get_connected_midi_inputs())

	for current_midi_input in OS.get_connected_midi_inputs():
		print(current_midi_input)
		$"Control/VBoxContainer/MidiInputsList".add_item(current_midi_input, null, false)


func _unhandled_input(event : InputEvent):

	if (event is InputEventMIDI):

		print(event)
