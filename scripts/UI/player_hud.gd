extends Control
@onready var hp_bar: ProgressBar = $StatsContainer/MarginContainer/VBoxContainer2/VBoxContainer/HpBar
@onready var dash_bar: ProgressBar = $StatsContainer/MarginContainer/VBoxContainer2/VBoxContainer2/DashBar
@onready var player: Player = $"../.."

func update_hp() -> void:
	hp_bar.max_value = player.max_hp
	hp_bar.value = player.hp

func update_dash_timer():
	dash_bar.max_value = player.dash_cd
	dash_bar.value = player.cd
	var fill_style := dash_bar.get_theme_stylebox("fill").duplicate()
	if dash_bar.value == dash_bar.max_value:	
		fill_style.bg_color = Color.GREEN
	else:
		fill_style.bg_color = Color.WHITE
	dash_bar.add_theme_stylebox_override("fill", fill_style)

func _physics_process(delta: float) -> void:
	update_dash_timer()
