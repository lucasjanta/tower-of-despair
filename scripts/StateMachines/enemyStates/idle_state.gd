extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var idle_cd : float = 0.0

func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	update_animation()
	player.velocity.x = 0
	idle_cd = randf_range(1.0, 3.0)
	
func update_animation():
	animated_sprite_2d.play("idle")
	if player.player_ref.global_position.x < player.global_position.x:
		animated_sprite_2d.flip_h = true
	elif player.player_ref.global_position.x > player.global_position.x:
		animated_sprite_2d.flip_h = false

func physics_update(delta):
	update_animation()
	if idle_cd > 0.0:
		idle_cd -= delta
	else:
		if player.distance_to_player < 30.0:
			if player.special_attack_cd <= 0.0:
				state_machine.change_state(state_machine.get_node("SpecialAttackState"))
				return
			if player.basic_attack_cd <= 0.0:
				state_machine.change_state(state_machine.get_node("BasicAttackState"))
				return
		
		if player.ring_cd <= 0.0 and player.distance_to_player <= 200.0:
			state_machine.change_state(state_machine.get_node("UseRingState"))
			return
		
		if player.distance_to_player >= 30.0:
			state_machine.change_state(state_machine.get_node("FollowState"))
			return
		else:
			state_machine.change_state(state_machine.get_node("FleeState"))
			return
