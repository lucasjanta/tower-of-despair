extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var hitbox: Area2D = $"../../Hitbox"
@onready var hitbox_collision: CollisionShape2D = $"../../Hitbox/CollisionShape2D"


func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	player.velocity.x = 0
	update_animation()
	
func update_animation():
	animated_sprite_2d.play("attack")
	if player.player_ref.global_position.x < player.global_position.x:
		animated_sprite_2d.flip_h = true
		hitbox.scale.x = -1
	elif player.player_ref.global_position.x > player.global_position.x:
		animated_sprite_2d.flip_h = false
		hitbox.scale.x = 1

func physics_update(delta):
	if animated_sprite_2d.frame == 3:
		hitbox_collision.disabled = false
	if animated_sprite_2d.frame == 5:
		hitbox_collision.disabled = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "attack":
		if player.special_attack_cd <= 0.0:
			state_machine.change_state(state_machine.get_node("SpecialAttackState"))
			return
		elif player.ring_cd <= 0.0 and player.distance_to_player <= 200.0:
			state_machine.change_state(state_machine.get_node("UseRingState"))
			return
		else:
			state_machine.change_state(state_machine.get_node("IdleState"))
			return

func exit():
	hitbox_collision.disabled = true
	player.basic_attack_cd = player.basic_attack_max_cd
