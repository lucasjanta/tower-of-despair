extends Enemy

@onready var state_label: Label = $StateLabel
@onready var state_machine: StateMachine = $StateMachine
@export var player_ref : Player
@onready var enemyname: Label = $CanvasLayer/StatsBar/MarginContainer/VBoxContainer/Enemyname
@onready var enemy_hp_bar: ProgressBar = $CanvasLayer/StatsBar/MarginContainer/VBoxContainer/EnemyHpBar


var hp : float
var ring_max_cd := 5.0
var ring_cd := 0.0
var basic_attack_max_cd := 2.0
var basic_attack_cd := 0.0
var special_attack_max_cd := 5.0
var special_attack_cd := 0.0
var distance_to_player : float

func _ready() -> void:
	hp = max_hp
	enemyname.text = enemy_name
	enemy_hp_bar.max_value = max_hp
	enemy_hp_bar.value = max_hp

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += delta * 850.0
	move_and_slide()
	
	distance_to_player = global_position.distance_to(player_ref.global_position)

	if ring_cd > 0.0:
		ring_cd -= delta
	else:
		ring_cd = 0.0
		
	if basic_attack_cd > 0.0:
		basic_attack_cd -= delta
	else:
		basic_attack_cd = 0.0
		
	if special_attack_cd > 0.0:
		special_attack_cd -= delta
	else:
		special_attack_cd = 0.0
		
	state_label.text = state_machine.current_state.name

func update_hp():
	enemy_hp_bar.value = hp

func take_damage(dmg):
	hp -= dmg
	update_hp()
	if hp <= 0.0:
		print("enemy died")


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(10)


func _on_hitbox_special_attack_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(25)
