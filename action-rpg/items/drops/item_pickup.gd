@tool
class_name ItemPickup extends CharacterBody2D

@export var item_drop_data : ItemDropData : set = _set_item_data
@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var wander_timer: Timer = $WanderTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	update_texture()
	update_audio()
	if Engine.is_editor_hint():
		return
	area_2d.body_entered.connect(_on_body_entered)
	if item_drop_data.velocity > 0:
		velocity = GlobalContants.get_random_dir8() * item_drop_data.velocity
		wander_timer.timeout.connect(_on_wander_timer_timeout)

func _physics_process(_adelta: float) -> void:
	move_and_slide()
	
func _on_body_entered(_b : Node2D) -> void:
	if _b is Player and item_drop_data:
		GlobalEventBus.player_pickup_item.emit(item_drop_data)
		item_picked_up()

func _set_item_data(value : ItemDropData) -> void:
	item_drop_data = value
	update_texture()
	update_audio()

func update_texture() -> void:
	if item_drop_data and sprite_2d:
		sprite_2d.texture = item_drop_data.texture
	pass	
	
func update_audio() -> void:
	if item_drop_data and audio_stream_player_2d:
		audio_stream_player_2d.stream = item_drop_data.audio	

func item_picked_up() -> void:
	area_2d.body_entered.disconnect( _on_body_entered )
	audio_stream_player_2d.play()
	visible = false	
	await audio_stream_player_2d.finished
	queue_free()
	pass

func _on_wander_timer_timeout() -> void:
	velocity = GlobalContants.get_random_dir8() * item_drop_data.velocity
	wander_timer.start(randf())
	pass


func _on_lifetime_timeout() -> void:
	animation_player.play("fade_out")
	await animation_player.animation_finished
	queue_free()
