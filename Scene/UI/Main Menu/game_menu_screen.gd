extends CanvasLayer


@onready var game_menu_screen_background: TextureRect = $GameMenuScreenBackground
@onready var game_over_screen_background_good_ending: TextureRect = $GameOverScreenBackgroundGoodEnding
@onready var game_over_screen_background_bad_ending: TextureRect = $GameOverScreenBackgroundBadEnding
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var label: Label = $MarginContainer/MainMenuMarginContainer/Label
@onready var options_menu_margin_container: MarginContainer = $MarginContainer/OptionsMenuMarginContainer
@onready var main_menu_margin_container: MarginContainer = $MarginContainer/MainMenuMarginContainer


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
	options_menu_margin_container.visible = true
	main_menu_margin_container.visible = false


func _on_quit_game_button_pressed() -> void:
	GameManager.quit_game()


func _exit_tree() -> void:
	audio_stream_player.stop()
	TimeManager.timestop = false


func _on_back_to_main_menu_game_button_pressed() -> void:
	options_menu_margin_container.visible = false
	main_menu_margin_container.visible = true
