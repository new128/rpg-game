"""
Класс предмета

Слоты:
	
				 
				head
				shoulders
	left hand	body	right hand
				legs

"""



"""
Ключи статов:
	
	damage
	armor
	max_hp
	speed
	max_mana
	regen_hp
	regen_mana
	mag_resist
	attack_speed
	attack_radius



"""

var characteristic = {} #  в словаре будет характеристика типо макс хп и значение изменения её
var name = null
var description = null
var price = null
var slot = null
var double_hends = null # двуручность т е нельзя во 2-ом слоте руки ничего держать\
var type_attack = null
var rarity = null #редкость
var Scil = preload("res://ability.gd")
var scil = null
var dressed = false
var attack_radius = null


func _init(name_):
	if name_ == "sword_is_rusty": #ржавый меч
		name = name_
		description = "An ordinary sword for suckers" # Если что это всё переводчик
		price = 500
		slot = "hand"
		double_hends = false
		characteristic["damage"] = +10
		rarity = "regular"
		type_attack = "melee"
		attack_radius = 1.5
	if name_ == "wooden_bow":
		name = name_
		description = "An ordinary bow"
		price = 500
		slot = "hand"
		double_hends = false
		characteristic["damage"] = +10
		rarity = "regular"
		type_attack = "range"
		attack_radius = 7
	if name_ == "regular_staff":
		name = name_
		description = "An ordinary staff"
		price = 500
		slot = "hand"
		double_hends = false
		characteristic["damage"] = +10
		rarity = "regular"
		type_attack = "range"
		attack_radius = 10
	if name_ == "tattered_mail": 
		name = name_
		description = "Regular armor for suckers" # Если что это всё переводчик
		price = 500
		slot = "body"
		double_hends = false
		characteristic["armor"] = +5
		characteristic["max_hp"] = +100
		rarity = "regular"
	if name_ == "speed_boots": 
		name = name_
		description = "Regular armor for suckers" # Если что это всё переводчик
		price = 500
		slot = "legs"
		double_hends = false
		characteristic["speed"] = +1.5
		rarity = "regular"
		
		
		
	
	if name_ == "falakaxa": 
		name = name_
		description = "Flask from dota" # Если что это всё переводчик
		price = 120
		slot = "consumables"
		double_hends = false
		rarity = "regular"
		scil = Scil.new("flask")
	if name_ == "pigeon": 
		name = name_
		description = "Claret from dota" # Если что это всё переводчик
		price = 90
		slot = "consumables"
		double_hends = false
		rarity = "regular"
		scil = Scil.new("clarety")
	if name_ == "fufarik":
		name = name_
		description = "fireman from dota" # Если что это всё переводчик
		price = 80
		slot = "consumables"
		double_hends = false
		rarity = "regular"
		scil = Scil.new("fairik")
	if name_ == "magago":
		name = name_
		description = "mango from dota" # Если что это всё переводчик
		price = 70
		slot = "consumables"
		double_hends = false
		rarity = "regular"
		scil = Scil.new("mango")
	

