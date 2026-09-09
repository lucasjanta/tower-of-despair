extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var idle_wait : float = 0.0

func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	update_animation()
	idle_wait = randf_range(2.0, 5.0)
	
func update_animation():
	animated_sprite_2d.play("walk")
	if player.player_ref.global_position.x < player.global_position.x:
		animated_sprite_2d.flip_h = true
	elif player.player_ref.global_position.x > player.global_position.x:
		animated_sprite_2d.flip_h = false

func physics_update(delta):
	update_animation()
	if player.distance_to_player < 30.0:
		if player.special_attack_cd <= 0.0:
			state_machine.change_state(state_machine.get_node("SpecialAttackState"))
			return
		elif player.basic_attack_cd <= 0.0:
			state_machine.change_state(state_machine.get_node("BasicAttackState"))
			return
		elif idle_wait > 0.0:
			state_machine.change_state(state_machine.get_node("FleeState"))
			return
		else:
			state_machine.change_state(state_machine.get_node("IdleState"))
			return
	else:
		player.velocity.x = player.speed * sign(player.player_ref.global_position.x - player.global_position.x)
		
	if player.ring_cd <= 0.0 and player.distance_to_player <= 200.0:
		state_machine.change_state(state_machine.get_node("UseRingState"))
		return
	
	if idle_wait > 0.0:
		idle_wait -= delta
	else:
		idle_wait = 0.0
