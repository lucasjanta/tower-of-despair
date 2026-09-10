extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
const FIREBALL = preload("uid://dactt5mwm51ln")

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
		fireball()
		state_machine.change_state(state_machine.get_node("IdleState"))
		return

func fireball():
	var new_fireball = FIREBALL.instantiate()
	new_fireball.dir = -1 if animated_sprite_2d.flip_h else 1
	new_fireball.global_position = player.global_position - Vector2(5, 0) if animated_sprite_2d.flip_h else player.global_position + Vector2(5, 0)
	player.get_parent().add_child(new_fireball)
	

func exit():
	player.ring_cd = player.ring_max_cd
