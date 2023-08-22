extends CharacterBody2D
class_name Player

##################################################################
# Definições e instanciando objetos
##################################################################

# painel no inspetor para instanciar as coisas
@export_category("Instanciar Objetos")
@export var _animation_tree: AnimationTree = null  
@export var _aceleration: float = 0.1
@export var _friction: float = 1

@export var _life_player: float = 100.0
@onready var barra_de_vida = $BarraDeVida
@onready var camera_2d = $Camera2D

#Links com os nós
@onready var atack_timer = $atackTimer
@onready var animations = $Animations
@onready var collision_area_attack = $AttackArea/CollisionShape2D

#definiçõede  de variaveis
const velocidade = 66.0
var _state_machine: AnimationNodeStateMachinePlayback = null 
var _weapon_damage:float = 35.0

# variaveis de controle
var _is_atacking:bool = false
var _is_dead:bool = false
var _is_hurt:bool = false
var _is_freez:bool = false

##################################################################
# Funções iniciais da Godot 4
##################################################################
func _ready() -> void:
	# usamos o methodo _ready, pois precisamos instanciar o _state_machine
	# quando os filhos estiverem instanciados
	_state_machine = _animation_tree["parameters/playback"]
	_animation_tree.active = true
	barra_de_vida.visible = true

func _physics_process(_delta) -> void:
	if _is_freez:
		_state_machine.travel("idle") 
		return
	# se o monstro matou o player desativa a physics_process
	# e chama a animação de morte la no monstro
	if _is_dead:
		return
	_move() #função de mover o personagem em 8 direções
	move_and_slide()
	_atack() # função handle de atack 
	_animate() #função responsável pelas animações

##################################################################
# Funções custon - helper Functions
##################################################################
func _move() -> void:
	
	var _direction: Vector2 = Input.get_vector(
		"ui_left","ui_right",
		"ui_up","ui_down"
	)
	
	if _direction:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction
		_animation_tree["parameters/attack/blend_position"] = _direction
	
	# aceleração no movimento
	if _direction != Vector2.ZERO:
		velocity.x = lerp(velocity.x,_direction.normalized().x * velocidade ,_aceleration)
		velocity.y = lerp(velocity.y,_direction.normalized().y * velocidade ,_aceleration)
		return
	
	#desaceleração (fricção) no movimento
	velocity.x = lerp(velocity.x,_direction.normalized().x * velocidade,_friction)
	velocity.y = lerp(velocity.y,_direction.normalized().y * velocidade,_friction)

	
func _animate() -> void:
	if _is_hurt:
		return
	# não precisamos chamar a animação de morte aqui,
	# pois acessamos ela diretamente do monstro
	if _is_atacking:
		_state_machine.travel("attack")
		return 
		
	if velocity:
		_state_machine.travel("walk") 
		return  
		
	_state_machine.travel("idle") 

############################################
#funções de ações basicas do player
############################################
func _atack() -> void:
	if Input.is_action_just_pressed("attack") and not _is_atacking:
		set_physics_process(false)
		_is_atacking = true
		$attackFX.play()
		atack_timer.start(0.4)

func _dead()->void:
	_is_dead = true
	Global._gameOver()
	$deadFX.play()
	_state_machine.travel("dead")

func _set_damage(weapon_damage):
	_life_player = _life_player - weapon_damage
	if _life_player < 90:
		barra_de_vida.value = _life_player
	
	if _life_player <= 35:
		Global._setMsg("Vida em prerigo!")
		$RespawMsgGame.start()
	if _life_player <= 0:
		_is_dead = true
		_dead()
	else: 
		_hurt()
		
func _setItemColetado(valor:float):
	if _life_player < 100:
		_life_player += valor
		barra_de_vida.value = _life_player
	return _life_player

func _hurt():
	_is_hurt = true
	$TimerHurt.start()
	_state_machine.travel("hurt")
	
##################################################################
# Signals = sinais 
##################################################################
func _on_atack_timer_timeout() -> void:
	_is_atacking = false
	set_physics_process(true)
	#não precisa desabilitar pois a propria animação faz isso 
	collision_area_attack.disabled = true 
	
func _on_attack_area_body_entered(_body):
	if _body is Slime:
		_body._set_damage(_weapon_damage) # criar este metodo no inimigo

func _on_timer_hurt_timeout():
	set_physics_process(true)
	_is_hurt = false

func _on_animation_tree_animation_finished(_anim_name):
	if _anim_name == "dead":
		Global._resetGame()

func _on_respaw_msg_game_timeout():
	Global._setMsg("")
