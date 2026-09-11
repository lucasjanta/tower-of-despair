extends Resource
class_name Ring

@export var ring_name : String
@export var max_uses: int = 20
@export var uses: int = 20
@export var texture : Texture2D

# 0 = Basic
# 1 = Experienced
# 2 = Ancient
@export_range(0, 2) var power_stage: int = 0

func use(player: Player) -> void:
	pass


func apply_passive(player: Player) -> void:
	pass


func remove_passive(player: Player) -> void:
	pass


func can_use() -> bool:
	return uses > 0


func consume_use() -> void:
	uses -= 1

	if uses <= 0:
		uses = 0
