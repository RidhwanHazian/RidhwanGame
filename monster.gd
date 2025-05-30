extends CharacterBody2D

signal monster_died

var health = 2

@onready var player = get_node("/root/Game/Player")
@onready var slime_anim = $Slime  # Use $ instead of % for node references

func _ready():
	slime_anim.play_walk()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()

func take_damage():
	health -= 1
	slime_anim.play_hurt()
	
	if health <= 0:
		emit_signal("monster_died")
		queue_free()

		var SMOKE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
