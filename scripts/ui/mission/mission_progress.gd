extends Control


@export var player_ui: PlayerUI
@export var mission_empty: MissionUI
@export var mission_complete: MissionUI


func _ready():
	player_ui.player.mission_progress_changed.connect(update)
	update()


func update():
	mission_complete.update(player_ui.player.current_mission_progress)
	mission_empty.update(player_ui.player.max_mission_progress)
