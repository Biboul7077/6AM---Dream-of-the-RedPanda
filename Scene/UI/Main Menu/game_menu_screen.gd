extends CanvasLayer


@onready var game_menu_screen_background: TextureRect = $GameMenuScreenBackground
@onready var game_over_screen_background_good_ending: TextureRect = $GameOverScreenBackgroundGoodEnding
@onready var game_over_screen_background_bad_ending: TextureRect = $GameOverScreenBackgroundBadEnding
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var label: Label = $MainMenuMarginContainer/Label
@onready var main_menu_margin_container: MarginContainer = $MainMenuMarginContainer
@onready var game_menu_settings: OptionMenu = $GameMenuSettings


func _ready() -> void:
	if game_over_screen_background_good_ending.visible:
		label.text = "You made it back to your body !"
	elif game_over_screen_background_bad_ending.visible:
		label.text = "Unfortunately, you didn't make it..."
	else:
		label.text = "DREAM OF A RED PANDA"
	audio_stream_player.play()
	TimeManager.timestop = true

func _on_start_game_button_pressed() -> void:
	GameManager.start_game()
	queue_free()


func _on_options_game_button_pressed() -> void:
	main_menu_margin_container.visible = false
	game_menu_settings.visible = true


func _on_quit_game_button_pressed() -> void:
	GameManager.quit_game()


func _on_game_menu_settings_exit_options_menu() -> void:
	main_menu_margin_container.visible = true
	game_menu_settings.visible = false


func _exit_tree() -> void:
	audio_stream_player.stop()
	TimeManager.timestop = false
