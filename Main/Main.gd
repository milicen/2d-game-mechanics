extends Node

signal set_load_button_state(state)

export(Vector2) var initial_char_pos
export(Vector2) var initial_camera_pos

export(Script) var save_data_script
var saved_vars = ["player_pos", "camera_pos"]

onready var character = $Level/Character
onready var camera = $Level/Camera2D
onready var main_menu = $MainMenu
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().set_auto_accept_quit(false)

	$Level.hide()
	character.set_physics_process(false)
	camera.current = false
	$MainMenu/Camera2D.current = true

	connect("set_load_button_state", main_menu, "_on_Main_set_load_button_state")

	main_menu.connect("load_game", self, "_on_MainMenu_load_game")
	main_menu.connect("new_game", self, "_on_MainMenu_new_game")
	main_menu.connect("load_settings", self, "_on_MainMenu_load_settings")
	main_menu.connect("game_quit", self, "_on_MainMenu_game_quit")
	
	emit_signal("set_load_button_state", load_data())

	print(character.global_position)

func _process(_delta):
	if(Input.is_action_just_pressed("quit")):
		get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save_data()
		get_tree().quit()

func save_data():
	var new_data = save_data_script.new()
	new_data.player_pos = character.global_position
	new_data.camera_pos = camera.global_position

	var directory = Directory.new()
	if !directory.dir_exists('res://saves/'):
		directory.make_dir_recursive('res://saves/')
		
	ResourceSaver.save('res://saves/save_data_01.tres', new_data)
	
	
func load_data():
	var directory = Directory.new()
	if !directory.file_exists('res://saves/save_data_01.tres'):
		return false
		
	var last_save_data = load('res://saves/save_data_01.tres')
		
	if !verify_save(last_save_data):
		return false
		
	character.global_position = last_save_data.player_pos
	camera.global_position = last_save_data.camera_pos
	
	return true
	
	
func verify_save(last_save_data):
	for vars in saved_vars:
		if last_save_data.get(vars) == null:
			return false
			
	return true


func renew_data():
	var new_data = save_data_script.new()
	new_data.player_pos = initial_char_pos
	new_data.camera_pos = initial_camera_pos

	var directory = Directory.new()
	if !directory.dir_exists('res://saves/'):
		directory.make_dir_recursive('res://saves/')
		
	ResourceSaver.save('res://saves/save_data_01.tres', new_data)



func _on_MainMenu_load_game():
	load_data()
	$Level.show()
	camera.current = true
	$MainMenu/Camera2D.current = false
	character.set_physics_process(true)

func _on_MainMenu_new_game():
	renew_data()
	load_data()
	$Level.show()
	camera.current = true
	$MainMenu/Camera2D.current = false
	character.set_physics_process(true)


func _on_MainMenu_load_settings():
	pass

func _on_MainMenu_game_quit():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
