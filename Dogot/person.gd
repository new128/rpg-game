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

# Все вышеперечисленные характеристики это те что могут меняться и будут изменены в начале игры при выборе класса и оружия

var xp = 0
var lvl = 1 # думаю сделаем как в большинстве РПГ игр xp впрогрессии увеличивается, только надо найти золотую серидину

var inventary = null
var money = null

var scills = [null]

var max_scils = null

func _init(class_person, inventory_):
	inventary = inventory_
	if class_person == "paladin":
		max_hp = 1000
		max_mana = 200
		regen_hp = 10
		regen_mana = 1
		armor = 10
		mag_resist = 30
		damage = 80
		attack_speed = 2
		attack_radius = null
		speed = 6
		max_scils = 3
	if class_person == "shooter":
		max_hp = 600
		max_mana = 500
		regen_hp = 4
		regen_mana = 4
		armor = 2
		mag_resist = 15
		damage = 75
		attack_speed = 1.5
		attack_radius = null
		speed = 7
		max_scils = 4
	if class_person == "magician":
		max_hp = 400
		max_mana = 700
		regen_hp = 2
		regen_mana = 10
		armor = 0
		mag_resist = 50
		damage = 100
		attack_speed = 0.5
		attack_radius = null
		speed = 4
		max_scils = 5
	if class_person == "crip":
		max_hp = 500
		max_mana = 0
		regen_hp = 4
		regen_mana = 0
		armor = 3
		mag_resist = 10
		damage = 50
		attack_speed = 2
		attack_radius = null
		speed = 7
		max_scils = 0
	mana = max_mana
	hp = max_hp
	
	# потом добавить перебор всего в инвентаре для увеличения характеристик и для записи скилов
