extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	player.velocity.x = 0
	update_animation()
	
func update_animation():
	animated_sprite_2d.play("use_ring")
	if player.player_ref.global_position.x < player.global_position.x:
		animated_sprite_2d.flip_h = true
	elif player.player_ref.global_position.x > player.global_position.x:
		animated_sprite_2d.flip_h = false



func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "use_ring":
		print("send projectile")
		state_machine.change_state(state_machine.get_node("IdleState"))
		return

func exit():
	player.ring_cd = player.ring_max_cd
