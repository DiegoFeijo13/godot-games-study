@tool
class_name DialogSystemNode extends CanvasLayer

signal finished

var is_active : bool = false
var text_in_progress : bool = false
var waiting_for_choice: bool = false

var text_speed : float = 0.02
var text_length : int = 0
var plain_text : String
var audio_pitch_base : float = 1.0

var dialog_items : Array[DialogItem]
var dialog_item_index : int = 0

@onready var dialog_ui: Control = $DialogUI
@onready var content: RichTextLabel = $DialogUI/TextContainer/RichTextLabel
@onready var name_label_container: PanelContainer = $DialogUI/LabelContainer
@onready var name_label: Label = $DialogUI/LabelContainer/NameLabel
@onready var dialog_progress_indicator: PanelContainer = $DialogUI/DialogProgressIndicator
@onready var timer: Timer = $DialogUI/Timer
@onready var audio: AudioStreamPlayer = $DialogUI/AudioStreamPlayer
@onready var choice_options: VBoxContainer = $DialogUI/VBoxContainer

func _ready() -> void:
	if Engine.is_editor_hint():
		if get_viewport() is Window:
			get_parent().remove_child(self)
			return
		return
	timer.timeout.connect(_on_timer_timeout)
	hide_dialog()

func _unhandled_input(event: InputEvent) -> void:
	if is_active == false:
		return	
	
	if(
		event.is_action_pressed("interact") or
		event.is_action_pressed("ui_accept")
	):
		if text_in_progress == true:
			content.visible_characters = text_length
			timer.stop()
			text_in_progress = false
			show_dialog_button_indicator(true)
			return
		elif waiting_for_choice == true:
			return
			
		dialog_item_index +=1
		if dialog_item_index < dialog_items.size():
			start_dialog()
		else:
			hide_dialog()

func show_dialog(_items : Array[DialogItem]) -> void:
	is_active = true
	dialog_ui.visible = true
	dialog_ui.process_mode = Node.PROCESS_MODE_ALWAYS
	dialog_items = _items
	dialog_item_index = 0
	get_tree().paused = true	
	await get_tree().process_frame
	start_dialog()
	
func hide_dialog() -> void:
	is_active = false	
	choice_options.visible = false
	dialog_ui.visible = false
	dialog_ui.process_mode = Node.PROCESS_MODE_DISABLED
	finished.emit()
	get_tree().paused = false

func start_dialog() -> void:
	waiting_for_choice = false
	show_dialog_button_indicator(false)
	var _d : DialogItem = dialog_items[dialog_item_index]
	if _d is DialogText:
		set_dialog_text(_d)
	elif _d is DialogChoice:
		set_dialog_choice(_d)

func start_timer() -> void:
	timer.wait_time = text_speed
	var _char := plain_text[content.visible_characters - 1]
	if ".!?;:".contains(_char):
		timer.wait_time *= 4
	elif ",".contains(_char):
		timer.wait_time *= 2
	timer.start()

func set_dialog_text(_d :DialogText) -> void:
	content.text = _d.text
	choice_options.visible = false
	
	if _d.npc_info:
		name_label_container.visible = true
		name_label.text = _d.npc_info.npc_name
		audio_pitch_base = _d.npc_info.dialog_audio_pitch
	else:
		name_label.text = ""
		name_label_container.visible = false
	
	content.visible_characters = 0
	text_length = content.get_total_character_count()
	plain_text = content.get_parsed_text()
	text_in_progress = true
	start_timer()

func set_dialog_choice(_d :DialogChoice) -> void:
	choice_options.visible = true
	waiting_for_choice = true
	for c in choice_options.get_children():
		c.queue_free()
	
	for i in _d.dialog_branches.size():
		var _new_choice : Button = Button.new()
		_new_choice.text = _d.dialog_branches[i].text
		_new_choice.pressed.connect(_dialog_choice_selected.bind(_d.dialog_branches[i]))
		choice_options.add_child(_new_choice)
		if i == 0:
			_new_choice.grab_focus()
	
	if Engine.is_editor_hint():
		return

func _dialog_choice_selected(_d : DialogBranch) -> void:
	choice_options.visible = false
	show_dialog(_d.dialog_items)
	pass

func show_dialog_button_indicator(_is_visible:bool) -> void:
	dialog_progress_indicator.visible = _is_visible
	#TODO: change icon when last message
	
func _on_timer_timeout() -> void:
	content.visible_characters += 1
	if content.visible_characters <= text_length:
		_play_audio_on_vowels()
		start_timer()
	else:
		show_dialog_button_indicator(true)
		text_in_progress = false
		
func _play_audio_on_vowels() -> void:
	var c := plain_text[content.visible_characters -1]
	if "aeiouy1234567890".contains(c.to_lower()):
		audio.pitch_scale = randf_range(audio_pitch_base - 0.04, audio_pitch_base + 0.04)
		audio.play()
