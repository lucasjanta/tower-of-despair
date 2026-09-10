extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var flee_timer : float = 0.0

func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	update_animation()
	flee_timer = randf_range(3.0, 4.0)
	
func update_animation():
	animated_sprite_2d.play("walk")
	if player.player_ref.global_position.x < player.global_position.x:
		animated_sprite_2d.flip_h = false
	elif player.player_ref.global_position.x > player.global_position.x:
		animated_sprite_2d.flip_h = true

func physics_update(delta):
	update_animation()
	if player.distance_to_player < 60.0:
		player.velocity.x = player.speed * sign(player.global_position.x - player.player_ref.global_position.x)
	if flee_timer <= 0.0 or player.distance_to_player > 60.0:
		state_machine.change_state(state_machine.get_node("IdleState"))
		return

	if player.ring_cd <= 0.0 and player.distance_to_player <= 200.0:
		state_machine.change_state(state_machine.get_node("UseRingState"))
		return

	if flee_timer > 0.0:
		flee_timer -= delta
	else:
		flee_timer = 0.0
