extends Actor

onready var stomp_area: Area2D = $StompDetector
onready var collision_shape: CollisionShape2D = $CollisionShape2D

export var score := 100


func _ready():
	set_physics_process(false)
	_velocity.x = -speed.x


func _on_StompDetector_body_entered(body):
	if body.global_position.y > stomp_area.global_position.y:
		return
	die()


func _physics_process(delta) -> void:
	_velocity.y += gravity * delta
	_velocity.x *= 1 if is_on_wall() else 1
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func die():
	collision_shape.disabled = true
	PlayerData.score += score
	queue_free()
