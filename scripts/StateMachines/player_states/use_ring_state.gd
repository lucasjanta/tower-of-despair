extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	update_animation()
	
func update_animation():
	pass
