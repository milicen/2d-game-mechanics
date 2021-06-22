extends CenterContainer


signal load_game()
signal new_game()
signal load_settings()
signal game_quit()

func _ready():
	if self.visible:
		print("menu visible")


func _on_Main_set_load_button_state(state):
	if !state:
		$VBoxContainer/LoadGame.disabled = true
	else:
		$VBoxContainer/LoadGame.disabled = false

func _on_LoadGame_pressed():
	emit_signal("load_game")
	button_state_handler(true)
	self.hide()

func _on_NewGame_pressed():
	var dir = Directory.new()
	if dir.file_exists('res://saves/save_data_01.tres'):
		$ConfirmationDialog.show()
	else:
		emit_signal("new_game")
		button_state_handler(true)
		self.hide()


func _on_Settings_pressed():
	emit_signal("load_settings")
	button_state_handler(true)

func _on_Quit_pressed():
	emit_signal("game_quit")

func _on_ConfirmationDialog_confirmed():
	emit_signal("new_game")
	button_state_handler(true)
	self.hide()


func button_state_handler(is_disabled):
	if is_disabled:
		$VBoxContainer/LoadGame.disabled = true
		$VBoxContainer/NewGame.disabled = true
		$VBoxContainer/Settings.disabled = true
		$VBoxContainer/Quit.disabled = true

	else:
		$VBoxContainer/LoadGame.disabled = false
		$VBoxContainer/NewGame.disabled = false
		$VBoxContainer/Settings.disabled = false
		$VBoxContainer/Quit.disabled = false