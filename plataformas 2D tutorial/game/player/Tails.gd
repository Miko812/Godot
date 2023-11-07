extends KinematicBody2D

const SPEED = 128 #velocidad
const FLOOR = Vector2(0,-1) #ubicacion del piso
const GRAVITY = 10 #gravedad
const jUMP_GEIHT = 384 #fuerza de salto
onready var motion : Vector2 = Vector2.ZERO #vector de movimiento
var can_move : bool = true #controlador de movimiento

func _physics_process(delta):
	motion_ctrl() #llamar a la funcion
	motion = move_and_slide(motion, FLOOR) #funcion de mover

func get_axis() -> Vector2: #obtener ejes
	var axis = Vector2.ZERO 
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) #obtener eje x
	return axis #retornar el valor de axis

func motion_ctrl(): #obtener datos de movimiento
	motion.y += GRAVITY #gravedad
	if can_move: #si can_move = true
		motion.x = get_axis().x * SPEED #obtener ejes y la velocidad
		if get_axis().x == 0: #si no se esta moviendo
			$AnimationPlayer.play("Idle") #eproducir animacion
		elif get_axis().x == 1: #si se mueve a la derecha
			$AnimationPlayer.play("Run")
			$Sprite.flip_h = false #no voltear el sprite
		elif get_axis().x == -1: #si se mueve a la izquierda
			$AnimationPlayer.play("Run")
			$Sprite.flip_h = true #voltear el sprite
	match is_on_floor(): #si esta en el suelo
		true:
			can_move = true #se puede mover
			if Input.is_action_just_pressed("ui_accept"): #salto
				motion.y -= jUMP_GEIHT #salto (se usa - para ir arriba y + para ir hacia abajo
		false: 
			if motion.y < 0: # si esta subiendo
				$AnimationPlayer.play("Jump")
			else: #si esta bajando
				$AnimationPlayer.play("Fall")
