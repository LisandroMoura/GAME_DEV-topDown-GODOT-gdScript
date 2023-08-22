extends CharacterBody2D
class_name Slime
############################################
#referenciar objetos do slime 
############################################
@onready var animation = $Animation

@onready var barra_de_vida = $BarraDeVida

############################################
#variáveis de controle
############################################
var _is_attacking: bool = false
var _is_dead: bool = false
var _is_hurt:bool = false
var _is_player_detect:bool = false
var _player_ref:Player = null
var _speed_walk: float = 22.0
var _distance_limit_to_can_attack:float = 13.0

var _life_mob: float = 100.0
var _weapon_damage:float = 10.0

############################################
#funções padrões da godot
############################################
func _ready()->void:
	if _is_player_detect:
		if _player_ref is Player:
			pass
		
func _physics_process(_delta)->void:
	if _is_dead:
		return
	_move()
	_flip()
	_attack()
	_animate()
	move_and_slide() #função de movimentação da godot
	
############################################
#funções basicas do objeto
############################################
func _move()->void:
	if _player_ref != null:
		if not _is_attacking:
			_detectPlayer()
		
		if _player_ref._is_dead:
			velocity = Vector2.ZERO
			_is_attacking = false
			move_and_slide()
			return
			
		var _direction: Vector2 = global_position.direction_to(_player_ref.global_position ).normalized()
		velocity = _direction * _speed_walk
		
func _flip()->void:
	if velocity.x > 0:
		$Texture.flip_h = false
	if velocity.x < 0:
		$Texture.flip_h = true

func _animate()->void:
	if _is_hurt:
		return
		
	if _is_attacking:
		$Animation.play("attack")
		return
		
	if velocity.length() > 10: # isso também funciona
		$Animation.play("walk")	
		return
		
	$Animation.play("idle")
	
############################################
#funções de ações basicas do objeto
############################################
func _detectPlayer()->void:
	# logica para o attack : distância entre o player e o moby
	# chama o methodo distante.to
	var _distance: float = global_position.distance_to(_player_ref.global_position)
	
	if _distance < _distance_limit_to_can_attack:
		_is_attacking = true
		
	if _distance > _distance_limit_to_can_attack:
		_is_attacking = false
		
func _hurt()->void:
	_is_hurt = true
	$TimerHurt.start()
	$Animation.play("hurt")
	set_physics_process(false)
	
func _attack()->void:
	if _is_attacking:
		if _player_ref != null:
			$attackFX.play()
			_player_ref._set_damage(_weapon_damage)
			_is_attacking = false
			set_physics_process(false)
			$CooldownAttack.start()


func _dead()->void:
	Global._conta_inigos_mortos()
	$hurtFX.play()
	animation.play("dead")

############################################
# funções de interações do objetos com outros 
# elementos na cena
############################################
func _set_damage(weapon_damage:float)->void:
	_life_mob = _life_mob - weapon_damage
	barra_de_vida.value = _life_mob
	if _life_mob <= 0:
		_is_dead = true
		_dead()
	else: 
		_hurt()

############################################
#signals - conectados
############################################

func _on_area_detect_body_entered(_body)->void:
	if _body is Player:
		_is_player_detect = true
		_player_ref = _body
#		_player_ref.barra_de_vida.visible = true
		self.barra_de_vida.visible = true


func _on_area_detect_body_exited(_body)->void:
	if _body is Player:
#		_player_ref.barra_de_vida.visible = false
		self.barra_de_vida.visible = false
		_is_player_detect = false
		_player_ref = null


func _on_timer_hurt_timeout():
	set_physics_process(true)
	_is_hurt = false

func _on_cooldown_attack_timeout():
	_is_attacking = false
	set_physics_process(true)
