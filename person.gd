#Класс всей информации о персонаже
#Основные переменные

var class_person = null # класс: ближник, дальник, маг и тд 
"""
Краткий экскур по классам:
	
	paladin
	Паладин: ближник, танк, рыцарь.
		Имеете max_hp = 1000
			max_mana = 200
			regen_hp = 10
			regen_mana = 1
			armor = 10
			mag_resist = 30
			damage = 80
			attack_speed = 2
			attack_radius = хз в чём измерять но примерно вытянутая рука
			speed = средняя скорость
			
			3 слота под скилы
		Мб вы скажите что он сильный даже по рамкам доты но у него не будет очивидных обилок. Те если он будет покупать вещи дающие обилки он сможет колдаватьт
		
		
	shooter
	Стрелок: лучник, чучело с луком, пкм герой.
		Имеете max_hp = 600
			max_mana = 500
			regen_hp = 4
			regen_mana = 4
			armor = 2
			mag_resist = 15
			damage = 75
			attack_speed = 1,5
			attack_radius = в 3 раза больше чем у паладина
			speed = быстрый
			
			4 слота под скилы
			
			1 дефолт скмл со старта. Которым можно будет изменить с помощью талантов
			
			
	magician
	Маг: пионист.
		Имеете max_hp = 400
			max_mana = 700
			regen_hp = 2
			regen_mana = 10
			armor = 0
			mag_resist = 50
			damage = 100
			attack_speed = 0,5
			attack_radius = в 4 раза больше чем у паладина
			speed = медленный
			
			5 слотов под скилы
			
			1 дефолт скил со старта но с помощью талантов можно получить ещё один и изменить старый

"""
var pers_type = "play_pers"

var team = null


# null сдешний None
var max_hp = null
var hp = max_hp

var max_mana = null
var mana = max_mana

var regen_hp = null
var regen_mana = null

var armor = null # это то насколько уменьшается физ урон. Допустим урон у врага с руки 100 он попадает по тебу кагда у тебя 20 брони и наносит 100-20 = 80
var mag_resist = null  # это процен блокировки магического урона. Допустим урон у врага магией 100 он попадает по тебу кагда у тебя 30 процентов резист и наносит 100-100*0.3 = 70

var damage = null
var attack_speed = null # Измеряется в за сколько секунд один удар
var attack_radius = null
var speed = null # ещё хз в чём измерять

var skils = []

# Все вышеперечисленные характеристики это те что могут меняться и будут изменены в начале игры при выборе класса и оружия

var xp = 0
var lvl = 1 # думаю сделаем как в большинстве РПГ игр xp впрогрессии увеличивается, только надо найти золотую серидину
var Inventary = preload("res://inventary.gd") 
var Item = preload("res://item.gd") 
var inventary = Inventary.new()
var money = 500

var scills = [null]

var max_scils = null

var time = null




func _init(class_person_, inventory_):
	if class_person_ == "paladin":
		class_person = "paladin"
		max_hp = 1000
		max_mana = 200
		regen_hp = 5
		regen_mana = 1
		armor = 10
		mag_resist = 30
		damage = 80
		attack_speed = 2
		attack_radius = 2.5
		speed = 6
		max_scils = 3
		inventary.weapon_r = Item.new("sword_is_rusty")
		inventary.legs = Item.new("speed_boots")
		inventary.body = Item.new("tattered_mail")
		inventary.consumables[0] = Item.new("falakaxa")
		inventary.consumables[1] = Item.new("pigeon")
		inventary.consumables[2] = Item.new("fufarik")
	if class_person_ == "shooter":
		class_person = "shooter"
		max_hp = 600
		max_mana = 500
		regen_hp = 2
		regen_mana = 4
		armor = 2
		mag_resist = 15
		damage = 75
		attack_speed = 1.5
		attack_radius = 7.5
		speed = 7
		max_scils = 4
	if class_person_ == "magician":
		class_person = "magician"
		max_hp = 400
		max_mana = 700
		regen_hp = 1
		regen_mana = 10
		armor = 0
		mag_resist = 50
		damage = 100
		attack_speed = 0.5
		attack_radius = 10
		speed = 4
		max_scils = 5
	if class_person_ == "crip":
		class_person = "crip"
		max_hp = 500
		max_mana = 0
		regen_hp = 2
		regen_mana = 0
		armor = 3
		mag_resist = 10
		damage = 50
		attack_speed = 2
		attack_radius = 2
		speed = 5
		max_scils = 0
		pers_type = "crip"
	if class_person_ == "tower":
		class_person = "tower"
		max_hp = 2000
		max_mana = 0
		regen_hp = 0
		regen_mana = 0
		armor = 25
		mag_resist = 10
		damage = 100
		attack_speed = 1
		attack_radius = 6
		speed = 0
		max_scils = 0
		pers_type = "tower"
	mana = max_mana
	hp = max_hp
	time = attack_speed
	


func taking_damage(type, damage):
	if type == "mag":
		hp -= damage - damage*mag_resist/100
	if type == "phis":
		hp -= damage - armor
	if type == "clear":
		hp -= damage
		
var attack_bool = false

func attack(attack_object, object):
	
	
	if not is_instance_valid(object):
		return
	print("attack")
	var obj1_position = Vector2(attack_object.global_transform.origin.x, attack_object.global_transform.origin.y)
	var obj2_position = Vector2(object.global_transform.origin.x, object.global_transform.origin.y)

	var dist = obj1_position.distance_to(obj2_position)
	
	attack_bool = true
	if object.person.class_person == "tower":
		dist -= 1
		
	if dist <= attack_radius:
		print("aaaaaa")
		print(object.person.hp)
		if time / 60 >= attack_speed*4:
			
			object.person.taking_damage("phis", damage)
			time = 0
			object.last_attack = self
	else:
		return 5
		
		
func count_stat():
	
	
	
	
	
	
	
	
	
	print(inventary.body.characteristic)
	for key in inventary.body.characteristic.keys():
		if key == "hp":
			if not inventary.body.dressed:
				hp = hp*max_hp/inventary.body.characteristic[key] # Пропорцианальное добавление хп
				max_hp += inventary.body.characteristic[key]
		if key == "armor":
			if not inventary.body.dressed:
				armor += inventary.body.characteristic[key]
		if key == "speed":
			if not inventary.body.dressed:
				speed += inventary.body.characteristic[key]
		if key == "damage":
			if not inventary.body.dressed:
				damage += inventary.body.characteristic[key]
		if key == "mana":
			if not inventary.body.dressed:
				mana = mana*max_mana/inventary.body.characteristic[key] # Пропорцианальное добавление хп
				max_mana += inventary.body.characteristic[key]
		if key == "reg_hp":
			if not inventary.body.dressed:
				regen_hp += inventary.body.characteristic[key]
		if key == "reg_mana":
			if not inventary.body.dressed:
				regen_mana += inventary.body.characteristic[key]
		if key == "mag_resist":
			if not inventary.body.dressed:
				mag_resist += inventary.body.characteristic[key]
		if key == "attack_speed":
			if not inventary.body.dressed:
				attack_speed += inventary.body.characteristic[key]
		if key == "attack_radius":
			if not inventary.body.dressed:
				attack_radius += inventary.body.characteristic[key]
		
	inventary.body.dressed = true
	
	
	for key in inventary.weapon_r.characteristic.keys():
		if key == "damage":
			if not inventary.weapon_r.dressed:
				damage += inventary.weapon_r.characteristic[key]
		if key == "hp":
			if not inventary.weapon_r.dressed:
				hp = hp*max_hp/inventary.weapon_r.characteristic[key] # Пропорцианальное добавление хп
				max_hp += inventary.weapon_r.characteristic[key]
		if key == "armor":
			if not inventary.weapon_r.dressed:
				armor += inventary.weapon_r.characteristic[key]
		if key == "speed":
			if not inventary.weapon_r.dressed:
				speed += inventary.weapon_r.characteristic[key]
		if key == "mana":
			if not inventary.weapon_r.dressed:
				mana = mana*max_mana/inventary.weapon_r.characteristic[key] # Пропорцианальное добавление хп
				max_mana += inventary.weapon_r.characteristic[key]
		if key == "reg_hp":
			if not inventary.weapon_r.dressed:
				regen_hp += inventary.weapon_r.characteristic[key]
		if key == "reg_mana":
			if not inventary.weapon_r.dressed:
				regen_mana += inventary.weapon_r.characteristic[key]
		if key == "mag_resist":
			if not inventary.weapon_r.dressed:
				mag_resist += inventary.weapon_r.characteristic[key]
		if key == "attack_speed":
			if not inventary.weapon_r.dressed:
				attack_speed += inventary.weapon_r.characteristic[key]
		if key == "attack_radius":
			if not inventary.weapon_r.dressed:
				attack_radius += inventary.weapon_r.characteristic[key]
	inventary.weapon_r.dressed = true
	
	for key in inventary.legs.characteristic.keys():
		if key == "speed":
			if not inventary.legs.dressed:
				speed += inventary.legs.characteristic[key]
		if key == "hp":
			if not inventary.legs.dressed:
				hp = hp*max_hp/inventary.legs.characteristic[key] # Пропорцианальное добавление хп
				max_hp += inventary.legs.characteristic[key]
		if key == "armor":
			if not inventary.legs.dressed:
				armor += inventary.legs.characteristic[key]
		if key == "damage":
			if not inventary.legs.dressed:
				damage += inventary.legs.characteristic[key]
		if key == "mana":
			if not inventary.legs.dressed:
				mana = mana*max_mana/inventary.legs.characteristic[key] # Пропорцианальное добавление хп
				max_mana += inventary.legs.characteristic[key]
		if key == "reg_hp":
			if not inventary.legs.dressed:
				regen_hp += inventary.legs.characteristic[key]
		if key == "reg_mana":
			if not inventary.legs.dressed:
				regen_mana += inventary.legs.characteristic[key]
		if key == "mag_resist":
			if not inventary.legs.dressed:
				mag_resist += inventary.legs.characteristic[key]
		if key == "attack_speed":
			if not inventary.legs.dressed:
				attack_speed += inventary.legs.characteristic[key]
		if key == "attack_radius":
			if not inventary.legs.dressed:
				attack_radius += inventary.legs.characteristic[key]
	inventary.legs.dressed = true
	
	if inventary.head:
		for key in inventary.head.characteristic.keys():
			if key == "speed":
				if not inventary.head.dressed:
					speed += inventary.head.characteristic[key]
			if key == "hp":
				if not inventary.head.dressed:
					hp = hp*max_hp/inventary.head.characteristic[key] # Пропорцианальное добавление хп
					max_hp += inventary.head.characteristic[key]
			if key == "armor":
				if not inventary.head.dressed:
					armor += inventary.head.characteristic[key]
			if key == "damage":
				if not inventary.head.dressed:
					damage += inventary.head.characteristic[key]
			if key == "mana":
				if not inventary.head.dressed:
					mana = mana*max_mana/inventary.head.characteristic[key] # Пропорцианальное добавление хп
					max_mana += inventary.head.characteristic[key]
			if key == "reg_hp":
				if not inventary.head.dressed:
					regen_hp += inventary.head.characteristic[key]
			if key == "reg_mana":
				if not inventary.head.dressed:
					regen_mana += inventary.head.characteristic[key]
			if key == "mag_resist":
				if not inventary.head.dressed:
					mag_resist += inventary.head.characteristic[key]
			if key == "attack_speed":
				if not inventary.head.dressed:
					attack_speed += inventary.head.characteristic[key]
			if key == "attack_radius":
				if not inventary.head.dressed:
					attack_radius += inventary.head.characteristic[key]
		inventary.head.dressed = true
	
	if inventary.shoulders:
		for key in inventary.shoulders.characteristic.keys():
			if key == "speed":
				if not inventary.shoulders.dressed:
					speed += inventary.shoulders.characteristic[key]
			if key == "hp":
				if not inventary.shoulders.dressed:
					hp = hp*max_hp/inventary.shoulders.characteristic[key] # Пропорцианальное добавление хп
					max_hp += inventary.shoulders.characteristic[key]
			if key == "armor":
				if not inventary.shoulders.dressed:
					armor += inventary.shoulders.characteristic[key]
			if key == "damage":
				if not inventary.shoulders.dressed:
					damage += inventary.shoulders.characteristic[key]
			if key == "mana":
				if not inventary.shoulders.dressed:
					mana = mana*max_mana/inventary.shoulders.characteristic[key] # Пропорцианальное добавление хп
					max_mana += inventary.shoulders.characteristic[key]
			if key == "reg_hp":
				if not inventary.shoulders.dressed:
					regen_hp += inventary.shoulders.characteristic[key]
			if key == "reg_mana":
				if not inventary.shoulders.dressed:
					regen_mana += inventary.shoulders.characteristic[key]
			if key == "mag_resist":
				if not inventary.shoulders.dressed:
					mag_resist += inventary.shoulders.characteristic[key]
			if key == "attack_speed":
				if not inventary.shoulders.dressed:
					attack_speed += inventary.shoulders.characteristic[key]
			if key == "attack_radius":
				if not inventary.shoulders.dressed:
					attack_radius += inventary.shoulders.characteristic[key]
		inventary.shoulders.dressed = true
	
	if inventary.weapon_l:
		for key in inventary.weapon_l.characteristic.keys():
			if key == "speed":
				if not inventary.weapon_l.dressed:
					speed += inventary.weapon_l.characteristic[key]
			if key == "hp":
				if not inventary.weapon_l.dressed:
					hp = hp*max_hp/inventary.weapon_l.characteristic[key] # Пропорцианальное добавление хп
					max_hp += inventary.weapon_l.characteristic[key]
			if key == "armor":
				if not inventary.weapon_l.dressed:
					armor += inventary.weapon_l.characteristic[key]
			if key == "damage":
				if not inventary.weapon_l.dressed:
					damage += inventary.weapon_l.characteristic[key]
			if key == "mana":
				if not inventary.weapon_l.dressed:
					mana = mana*max_mana/inventary.weapon_l.characteristic[key] # Пропорцианальное добавление хп
					max_mana += inventary.weapon_l.characteristic[key]
			if key == "reg_hp":
				if not inventary.weapon_l.dressed:
					regen_hp += inventary.weapon_l.characteristic[key]
			if key == "reg_mana":
				if not inventary.weapon_l.dressed:
					regen_mana += inventary.weapon_l.characteristic[key]
			if key == "mag_resist":
				if not inventary.weapon_l.dressed:
					mag_resist += inventary.weapon_l.characteristic[key]
			if key == "attack_speed":
				if not inventary.weapon_l.dressed:
					attack_speed += inventary.weapon_l.characteristic[key]
			if key == "attack_radius":
				if not inventary.weapon_l.dressed:
					attack_radius += inventary.weapon_l.characteristic[key]
		inventary.weapon_l.dressed = true