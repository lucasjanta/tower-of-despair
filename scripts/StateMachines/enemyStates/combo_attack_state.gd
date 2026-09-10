extends State
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var hitbox: Area2D = $"../../Hitbox"
@onready var hitbox_collision: CollisionShape2D = $"../../Hitbox/CollisionShape2D"
@onready var hitbox_special_attack: Area2D = $"../../HitboxSpecialAttack"
@onready var hitbox_special_attack_collision: CollisionShape2D = $"../../HitboxSpecialAttack/CollisionShape2D"

@onready var special_slash: AnimatedSprite2D = $"../../special_slash"

func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	player.velocity.x = 0
	update_animation()
	
	
func update_animation():
	animated_sprite_2d.play("special_attack")
	
	
	if player.player_ref.global_position.x < player.global_position.x:
		animated_sprite_2d.flip_h = true
		hitbox.scale.x = -1
		
		hitbox_special_attack.scale.x = -1
		special_slash.flip_h = false
		special_slash.position.x = -10.0
		
	elif player.player_ref.global_position.x > player.global_position.x:
		animated_sprite_2d.flip_h = false
		hitbox.scale.x = 1
		
		hitbox_special_attack.scale.x = 1
		special_slash.flip_h = true
		special_slash.position.x = 10.0

func physics_update(delta):
	if animated_sprite_2d.frame == 3:
		hitbox_collision.disabled = false
	if animated_sprite_2d.frame == 5:
		hitbox_collision.disabled = true
		special_slash.play("slash_diagonal")
		special_slash.visible = true
	
	if special_slash.frame == 3:
		hitbox_special_attack_collision.disabled = false
	if special_slash.frame == 7:
		hitbox_special_attack_collision.disabled = true
	

func exit():
	hitbox_collision.disabled = true
	hitbox_special_attack_collision.disabled = true
	special_slash.visible = false
	player.special_attack_cd = player.special_attack_max_cd


func _on_special_slash_animation_finished() -> void:
	if player.basic_attack_cd <= 0.0 and player.distance_to_player < 15.0:
		state_machine.change_state(state_machine.get_node("BasicAttackState"))
		return
	elif player.ring_cd <= 0.0 and player.distance_to_player <= 200.0:
		state_machine.change_state(state_machine.get_node("UseRingState"))
		return
	else:
		state_machine.change_state(state_machine.get_node("IdleState"))
		return
