extends KinematicBody2D

onready var spawn = global_position

var motion = Vector2()
const UP = Vector2(0, -1)
const GRAVITY = 30
const WALL_SLIDE_SPEED = 60
const SPEED = 50
const MAX_SPEED = 320
const FRICTION = 1500
const JUMP_HEIGHT = -600
const WALL_JUMP_HEIGHT = -600
const WALL_JUMP_SPEED = 400

var jumps = 0
enum {NO_JUMP, ONE_JUMP, WALL_JUMP, TWO_JUMP}
var level = NO_JUMP

onready var jump_display = get_tree().get_nodes_in_group("jump display")[0]

func max_jumps():
	match level:
		NO_JUMP: return 0
		ONE_JUMP: return 1
		WALL_JUMP: return 1
		TWO_JUMP: return 2

func _physics_process(delta):
	var go_left = Input.is_action_pressed("ui_left")
	var go_right = Input.is_action_pressed("ui_right")
	var go_up = Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_select")
	
	if level < WALL_JUMP or not is_on_wall():
		motion.y += GRAVITY
	else:
		motion.y = WALL_SLIDE_SPEED
	
	var stopping = true
	if go_left and not go_right:
		motion.x -= SPEED
		stopping = false
	elif go_right and not go_left:
		motion.x += SPEED
		stopping = false
	motion.x = max(motion.x, -MAX_SPEED)
	motion.x = min(motion.x, MAX_SPEED)
	
	if stopping:
		var vsign = sign(motion.x)
		var vlen = abs(motion.x)
		var friction = FRICTION
		vlen -= friction * delta
		if vlen < 0:
			vlen = 0
		motion.x = vlen * vsign
	
	if jumps < max_jumps():
		if is_on_floor():
			refresh()
		if level >= WALL_JUMP and is_on_wall():
			refresh()
	
	if go_up and jumps > 0:
		jumps -= 1
		if level < WALL_JUMP or not is_on_wall():
			motion.y = JUMP_HEIGHT
		else:
			motion.y = WALL_JUMP_HEIGHT
			if go_left and not go_right:
				motion.x = WALL_JUMP_SPEED
			elif go_right and not go_left:
				motion.x = -WALL_JUMP_SPEED
		if jumps == 0:
			jump_display.play("jump1")
		else:
			jump_display.play("jump2")
	
	if touch_death(): die()
	
	motion = move_and_slide(motion, UP)

func checkpoint(touched_checkpoint):
	spawn = Vector2(
		touched_checkpoint.global_position.x,
		global_position.y
	)

func die():
	set_global_position(spawn)
	motion = Vector2(0, 0)
	refresh()

func refresh():
	var mj = max_jumps()
	if jumps == 0:
		jump_display.play("refresh1")
	elif jumps == 1 and mj == 2:
		jump_display.play("refresh2")
	jumps = mj

func upgrade():
	level += 1
	get_node("../Blocks").set_level(level)

func touch_death():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("death"):
			return true
	return false