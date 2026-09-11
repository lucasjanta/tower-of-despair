extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var dir : int
var speed := 150.0
var dmg := 20.0
var hit := false
var player_is_owner := false

func _ready() -> void:
	if dir > 0:
		animated_sprite_2d.flip_v = false
	elif dir < 0:
		animated_sprite_2d.flip_v = true
	animated_sprite_2d.play("fly")

func _physics_process(delta: float) -> void:
	if !hit:
		global_position.x += dir * (delta * speed)


func _on_body_entered(body: Node2D) -> void:
	if body is Player and !player_is_owner:
		body.take_damage(dmg)
		hit = true
		animated_sprite_2d.play("explode")
		return
	
	if body is Enemy and player_is_owner:
		body.take_damage(dmg)
		hit = true
		animated_sprite_2d.play("explode")
		return

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "explode":
		queue_free()
