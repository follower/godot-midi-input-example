extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.open_midi_inputs()

	print(OS.get_connected_midi_inputs())

	for current_midi_input in OS.get_connected_midi_inputs():
		print(current_midi_input)
		$"Control/VBoxContainer/MidiInputsList".add_item(current_midi_input, null, false)


# via <https://github.com/godotengine/godot/blob/master/core/os/input_event.h>
enum GlobalScope_MidiMessageList {
	MIDI_MESSAGE_NOTE_OFF = 0x8,
	MIDI_MESSAGE_NOTE_ON = 0x9,
	MIDI_MESSAGE_AFTERTOUCH = 0xA,
	MIDI_MESSAGE_CONTROL_CHANGE = 0xB,
	MIDI_MESSAGE_PROGRAM_CHANGE = 0xC,
	MIDI_MESSAGE_CHANNEL_PRESSURE = 0xD,
	MIDI_MESSAGE_PITCH_BEND = 0xE,
};


const MIDI_EVENT_PROPERTIES = ["channel", "message", "pitch", "velocity", "instrument", "pressure", "controller_number", "controller_value"]


func get_midi_message_description(event : InputEventMIDI):

	if GlobalScope_MidiMessageList.values().has(event.message):
		return GlobalScope_MidiMessageList.keys()[event.message - 0x08]
	return event.message


func _unhandled_input(event : InputEvent):

	if (event is InputEventMIDI):

		var event_dump : String = ""

		#event_dump += "chn: {channel} msg: {message}\n".format({"channel": event.channel, "message": event.message})
		#event_dump += "  pitch: {pitch} vel: {velocity}\n".format({"pitch": event.pitch, "velocity": event.velocity})

		event_dump += "event: {0}\n".format([get_midi_message_description(event)])

		for current_property in MIDI_EVENT_PROPERTIES:
			event_dump += "  {0}: {1}\n".format([current_property, event.get(current_property)])

		event_dump += "\n"

		# NOTE: Having "Scroll Following" enabled seems to break things if there are
		#       too many messages sent at once.
		$"Control/VBoxContainer/Container/RichTextLabel".add_text(event_dump)
