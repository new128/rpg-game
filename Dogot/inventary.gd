"""
ИНВЕНТАРЮ

Как выгледит инвентарь:
	
				Головной убор
				Плечи: наплечники, плащ
	Оружие		Туловище(и не только ещё ноги и руки это один слот, ПОКА): броня, мантии			Оружие:
				Ботинки

"""

#var inventary = preload("res://inventary.gd")  создание объекта этого класса
var Item = preload("res://item.gd") 

var head = null

var shoulders = null

var weapon_r = null

var weapon_l = null

var body = null

var legs = null # обувь

var consumables = [] # расходники по типу кларетки и фласки в доте. максимально 3 штуки




