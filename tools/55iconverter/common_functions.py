# -*- coding: utf-8 -*-

import glob,time, traceback

class NoSuchTypeException (Exception):
	def __init__(self, text):
		self.text=text

class NoSuchContainerException (Exception):
	def __init__(self, text):
		self.text=text

class NoSuchHouseOwner (Exception):
	def __init__(self):
		return
class valueNullException (Exception):
	def __init__(self):
		return
class ignoreItemException (Exception):
	def __init__(self):
		return

glob.typemap = { "T_NORMAL":"1", "T_RUNE":"6", "T_KEY":"7", "T_SPELLBOOK":"9", "T_MAP":"10", "T_BOOK":"11", "T_DOOR":"12", "T_DOOR_LOCKED":"13"
	,"T_FOOD":"14", "T_WAND":"15", "T_SHRINE":"16", "T_POTION":"19", "T_SECURE":"64", "T_CONTAINER_LOCKED":"64", "T_CONTAINER":"63", "T_ADVANCE_GATE":"80"
	,"T_GARBAGE":"87", "T_SHIP":"117", "T_TELEPAD":"104", "T_BOOZE":"105", "T_STONE_GUILD":"202", "T_L1MAP":"1", "T_L2MAP":"1", "T_L3MAP":"1"
	, "T_L4MAP":"1", "T_L5MAP":"1", "T_SIGN_GUMP":"203"}

glob.trapDefs= { "t_normal" : "6", "t_trap":"1", "t_explosion":"2", "t_fire":"3", "t_weapon_sword":"4", "t_wall":"6", "t_weapon_fence":"5" }

def calculatePriv(hexvalue):
#attr_identified		00001	// This is the identified name. ???
#attr_decay			00002	// Timer currently set to decay.
#attr_newbie			00004	// Not lost on death or sellable ?
#attr_move_always	00008	// Always movable (else Default as stored in client) (even if MUL says not movalble) NEVER DECAYS !
#attr_move_never		00010	// Never movable (else Default as stored in client) NEVER DECAYS !
#attr_magic			00020	// DON'T SET THIS WHILE WORN! This item is magic as apposed to marked or markable.
#attr_owned			00040	// This is owned by the town. You need to steal it. NEVER DECAYS !
#attr_invis			00080	// Gray hidden item (to GM's or owners?)
#attr_cursed			00100
#attr_cursed2		00200	// cursed damned unholy
#attr_blessed		00400
#attr_blessed2		00800	// blessed sacred holy
#attr_forsale		01000	// For sale on a vendor.
#attr_stolen			02000	// The item is hot. m_uidLink = previous owner.
#attr_can_decay		04000	// This item can decay. but it would seem that it would not (ATTR_MOVE_NEVER etc)
#attr_static			08000	// WorldForge merge marker. (not used)
	priv=0
	attr=long("0x"+hexvalue,16)
	if ( attr & 2):
		priv+=1
	if ( attr & 4):
		priv+=2
	if (( attr & 8 )  or ( attr & 0x10 ) or ( attr & 0x40 )):
		if ( priv % 2 == 1):
			priv-=1
	return str(priv)

def getVisibility(hexvalue):
	priv=0
	attr=long("0x"+hexvalue,16)
	if ( attr & 0x080 ):
		return "2"
	return "0"

def getMovability(hexvalue):
	priv=0
	attr=long("0x"+hexvalue,16)
	if ( attr & 0x08 ):
		return "0"
	if ( attr & 0x10 ):
		return "2"
	return "1"


def decimal(hexvalue):
	if ( hexvalue.startswith("0")):
		hexvalue="0x0"+ hexvalue[1:]
	else:
		return hexvalue
	value=str(long(hexvalue,16)).strip()
	return value


def calculateCharAge(timeSinceCreation):
	# age ist nun Sekunden seit 1.1. 1970 bis zur Erstellung
	age=time.time()-long(timeSinceCreation)
	# age wird zu Tagen seit 1970
	age/=86400
	return str(long(age))


def getHouseOwner(ownerId, houseid):
	if ( houseid.upper() == "04FFFFFFF" ):
		raise valueNullException()
	if (not glob.houseOwner.has_key(houseid)):
		if ( ownerId == None ):
			raise NoSuchHouseOwner
		else:
			glob.houseOwner[houseid]=ownerId
	return glob.houseOwner[houseid]

def getSpawnType(value):
	if ( value.startswith("c_")):
		return "62"
	elif ( value.startswith("i_")):
		return "61"
	else:
	# Default Npc Spawn
		return "62"

glob.shipParts={}
def setShipPart(shipserial, partserial, type, xpos, ypos, dir):
	if ( glob.shipParts.has_key(shipserial)):
		shipparts=glob.shipParts[shipserial]
	else:
		shipparts=[None]*8
	if ( shipserial != None and partserial == None):
		# 0 North, 1 East, 2 South, 3 West
		shipparts[4]=dir
		shipparts[5]=xpos
		shipparts[6]=ypos
	# Füllen der Schiffswerte
	# Das Schiff ruft mit partserial None und type = 0 für tillerman, 1 für hatch, 2 für left plank, 3 für right plank auf
	if ( partserial == None):
		if ( shipparts[type] == None ):
		# Trick, um die Reihenfolge der Items im Worldsave zu umgehen, sobald das Array nicht vollständig ist
		# wird eine Exception geraised, die dazu führt, daß die Items in den Array mit fehlerhaften Items landen
		# Diese werden im zweitne Lauf erneut konvertiert, wenn alle Informationen vorhanden sind
			raise KeyError
		else:
			return shipparts[type]
	if ( partserial != None ):
		if ( type == 0 or type == 1):
			shipparts[type]=partserial
		# type -1 ist reserviert für ship planks, die noch nciht wissen, auf welcher Seite sie sind
		if ( type == -1 ):
			ship_xpos=shipparts[5]
			ship_ypos=shipparts[6]
			dir = shipparts[4]
			if ( dir==0 ):
				if ( xpos > ship_xpos ):
					# right plank
					shipparts[3]=partserial
				elif ( xpos < ship_xpos ):
					shipparts[2]=partserial
				else:
					raise Exception
			elif ( dir == 1):
				if ( ypos > ship_ypos ):
					# right plank
					shipparts[3]=partserial
				elif (ypos < ship_ypos ):
					shipparts[2]=partserial
				else:
					raise Exception
			elif ( dir==3 ):
				if ( xpos > ship_xpos ):
					# right plank
					shipparts[2]=partserial
				elif ( xpos < ship_xpos ):
					shipparts[3]=partserial
				else:
					raise Exception
			elif ( dir == 2):
				if ( ypos > ship_ypos ):
					# right plank
					shipparts[2]=partserial
				elif (ypos < ship_ypos ):
					shipparts[3]=partserial
				else:
					raise Exception
# Ship Parts Array 0: tillerman
# Ship Parts Array 1: hatch
# Ship Parts Array 2: left plank
# Ship Parts Array 3: right plank
# Ship Parts Array 4: shipdirection
# Ship Parts Array 5: ship xpos
# Ship Parts Array 6: ship ypos
	glob.shipParts[shipserial]=shipparts
	return shipserial

def mapSphereType(type, default = None):

	if ( glob.typemap.has_key(type.upper())):
		return glob.typemap[type.upper()]
	else:
		if ( default != None ):
			return glob.typemap[default.upper()]
		return "1"

def getOwnerKoors(attr, ownerId):

	player = glob.accSerialIndex[ownerId]

	if ( player.hasAttr(attr) ):
		return player.getAttr(attr)
	else:
		return "0"

def getCharMapping(charid):
	if ( glob.charMappingTable.has_key(charid)):
		return glob.charMappingTable[charid]
	else:
		raise Exception

def getContainer(contId):
	if ( glob.serialIndex.has_key(contId)):
		return glob.serialIndex[contId]
	else:
		raise NoSuchContainerException

def calculatePotion(value):
	if ( value.upper() == "TYPE_AGILITY"):
		return glob.symbolTable["$lesser_agility_potion"]
	if ( value.upper() == "TYPE_AGILITYGREAT"):
		return glob.symbolTable["$greater_agility_potion"]
	if ( value.upper() == "TYPE_STRENGTH"):
		return glob.symbolTable["$normal_strength_potion"]
	if ( value.upper() == "TYPE_STRENGTHGREAT"):
		return glob.symbolTable["$greater_strength_potion"]
	if ( value.upper() == "TYPE_CURELESS"):
		return glob.symbolTable["$lesser_cure_potion"]
	if ( value.upper() == "TYPE_CURE"):
		return glob.symbolTable["$normal_cure_potion"]
	if ( value.upper() == "TYPE_CUREGREAT"):
		return glob.symbolTable["$greater_cure_potion"]
	if ( value.upper() == "TYPE_EXPLOSIONLESS"):
		return glob.symbolTable["$lesser_explosion_potion"]
	if ( value.upper() == "TYPE_EXPLOSION"):
		return glob.symbolTable["$normal_explosion_potion"]
	if ( value.upper() == "TYPE_EXPLOSIONGREAT"):
		return glob.symbolTable["$greater_explosion_potion"]
	if ( value.upper() == "TYPE_SHRINK"):
		return glob.symbolTable["$item_shrink_potion"]
	if ( value.upper() == "TYPE_HEALLESS"):
		return glob.symbolTable["$lesser_healing_potion"]
	if ( value.upper() == "TYPE_HEAL"):
		return glob.symbolTable["$normal_healing_potion"]
	if ( value.upper() == "TYPE_HEALGREAT"):
		return glob.symbolTable["$greater_healing_potion"]
	if ( value.upper() == "TYPE_MANA"):
		return glob.symbolTable["$normal_mana_potion"]
	if ( value.upper() == "TYPE_MANAGREAT"):
		return glob.symbolTable["$greater_mana_potion"]
	if ( value.upper() == "TYPE_NIGHTSIGHT"):
		return glob.symbolTable["$greater_nightsight_potion"]
	if ( value.upper() == "TYPE_POISONLESS"):
		return glob.symbolTable["$lesser_poison_potion"]
	if ( value.upper() == "TYPE_POISON"):
		return glob.symbolTable["$normal_poison_potion"]
	if ( value.upper() == "TYPE_POISONGREAT"):
		return glob.symbolTable["$greater_poison_potion"]
	if ( value.upper() == "TYPE_POISONDEADLY"):
		return glob.symbolTable["$deadly_poison_potion"]
	if ( value.upper() == "TYPE_REFRESH"):
		return glob.symbolTable["$normal_energy_potion"]
	if ( value.upper() == "TYPE_REFRESHTOTAL"):
		return glob.symbolTable["$greater_energy_potion"]
	if ( value.upper() == "TYPE_RESTORE"):
		return glob.symbolTable["$item_restoration_potion"]
	if ( value.upper() == "TYPE_RESTOREGREAT"):
		return glob.symbolTable["$item_great_restoration_potion"]
	raise Exception

def findHouseLink(linkid):
	if ( glob.serialIndex.has_key(linkid)):
		return glob.serialIndex[linkid]
	else:
		raise valueNullException()

def bookRWState(value):
	if ( value == "0ffff"):
		return "333"
	else:
		return "666"
	return "666"

def chooseSellBox(layer):
	if ( layer == "26"):
		return "21"
	raise ignoreItemException