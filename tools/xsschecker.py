#!/usr/bin/python
# -*- coding: utf-8 -*-

# This tool was conceived and written by Straylight, Ultima Online freeshard Anacron.
# Additional help provided by Lina and Haegar, also from Anacron


#	This program is free software; you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation; either version 2 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with this program; if not, write to the Free Software
#	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#	* In addition to that license, if you are running this program or modified	*
#	* versions of it on a public system you HAVE TO make the complete source of *
#	* the version used by you available or provide people with a location to	*
#	* download it.


import glob, os, sys, getopt
import re
import cPickle, compiler
import gc

from characters import *
from items import *

glob.lastline=""

allowedItemAttributes=[ "AMOUNT", "ATT", "AMXFLAG0", "AMXFLAG1", "AMXFLAG2", "AMXFLAG3", "AMXFLAG4", "AMXFLAG5", "AMXFLAG6", "AMXFLAG7", "AMXINT"
	, "AMXSTR", "ANIMID", "AUXDAMAGE", "AUXDAMAGETYPE", "AMMO", "AMMOFX"
	, "COLOR", "CONTAINS", "CONTAINLIST", "CREATOR", "COLORLIST"
	, "DAMAGE", "DAMAGETYPE", "DEX", "DISABLED", "DISABLEMSG", "DISPELLABLE", "DECAY", "DIR", "DYE", "DEXADD", "DEF"
	,"FIGHTSKILL"
	,"GOOD"
	,"HIDAMAGE", "HP"
	,"ID","ITEMLIST","INT", "INTADD", "ITEMHAND"
	,"LAYER", "LODAMAGE"
	,"MORE", "MORE2", "MOVABLE", "MAXHP", "MOREX", "MOREY", "MOREZ"
	,"NEWBIE", "NAME", "NAME2"
	,"OFFSPELL"
	,"POISONED","PILE"
	,"RANK","REQSKILL", "RESISTS"
	,"SK_MADE", "SMELT", "STR", "SPD","STRADD"
	,"TYPE","TRIGGER","TRIGTYPE"
	,"USES"
	,"VISIBLE","VALUE"
	,"WEIGHT"
	]

# Type 0 : String
# Type 1 : Numeric/symbol
# Type 2 : Ranged
# Type 3 : Multiple Values
# Type 4 : Hex Value
# Type 5 : No argument
# Type 6 : Float
allowedItemAttrType= (
	1, 2 , 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 1, 1, 1, 1, 4 # A
	,4, 3, 3, 0, 1									# C
	,2, 1, 1, 1, 0, 5, 5, 1, 1, 1, 1					# D
	,1												# F
	,1												# G
	,1,2 											# H
	,4,1,1,1,1										# I
	,1,1											# L
	,1,1,1,1,1,1,1									# M
	,5,0,0											# N
	,1												# O
	,1,1											# P
	,1,3,3											# R
	,1,1,1,1,1										# S
	,1,1,1											# T
	,1												# U
	,1,1											# V
	,1												# W
	)

allowedCharAttributes=[
	"ALCHEMY", "AMOUNT", "AMXFLAG0", "AMXFLAG1", "AMXFLAG2", "AMXFLAG3", "AMXFLAG4", "AMXFLAG5", "AMXFLAG6", "AMXFLAG7", "AMXFLAG8", "AMXFLAG9", "AMXFLAGA"
	, "AMXFLAGB", "AMXFLAGC", "AMXFLAGD", "AMXFLAGE", "AMXFLAGF", "AMXINT", "AMXINTVEC", "AMXSTR", "ANATOMY","ANIMALLORE", "ARCHERY", "ARMSLORE", "ATT"
	, "BACKPACK", "BEGGING", "BLACKSMITHING", "BOWCRAFT"
	,"COLOR","CAMPING","CANTRAIN","CARVE","CARPENTRY","CARTOGRAPHY","COLORMATCHHAIR","COLORLIST","COOKING"
	,"DAMAGE","DAMAGETYPE","DEF","DETECTINGHIDDEN","DEX","DEXTERITY","DIRECTION","DOORUSE"
	,"EMOTECOLOR", "EVALUATINGINTEL"
	,"FAME","FENCING","FLEEAT","FISHING","FOLLOWSPEED","FX1","FX2","FY1","FY2","FZ1","FORENSICS"
	,"GOLD", "GENDER"
	,"HAIRCOLOR", "HEALING", "HERDING", "HIDAMAGE", "HIDING", "HOLYDAMAGED"
	, "ID", "INSCRIPTION", "INT", "INTELLIGENCE", "INVULNERABLE", "ITEM", "ITEMID"
	, "KARMA"
	, "LIGHTDAMAGED", "LOCKPICKING", "LODAMAGE", "LOOT", "LOOTITEM", "LUMBERJACKING"
	,"MACEFIGHTING", "MAGERY", "MAGICRESISTANCE","MAGICSPHERE", "MAGICLEVEL","MEDITATION", "MINING", "MOVESPEED", "MUSICIANSHIP"
	, "NAME", "NAMELIST", "NOTRAIN", "NPCAI", "NPCWANDER","NXWFLAG0","NXWFLAG1","NXWFLAG2","NXWFLAG3", "NPCLIST"
	, "ONHORSE"
	, "PACKITEM", "PARRYING", "PEACEMAKING", "POISON", "POISONING", "PRIV1", "PRIV2", "PROVOCATION"
	, "RACE", "REATTACKAT", "REGEN_HP", "REGEN_ST", "REGEN_MN","REMOVETRAPS", "RESISTS","RSHOPITEM"
	, "SAYCOLOR", "SELLITEM", "SHOPITEM", "SHOPKEEPER", "SKILL", "SKIN", "SPEECH", "SKIN", "SKINLIST", "SNOOPING", "SPADELAY", "SPATTACK", "SPEECH"
	, "SPIRITSPEAK", "SPLIT", "SPLITCHANCE", "STABLEMASTER", "STEALING", "STEALTH", "STR", "STRENGTH", "SWORDSMANSHIP"
	, "TACTICS", "TAMING", "TAILORING", "TASTEID", "TINKERING", "TITLE", "TOTAME", "TRACKING", "TRIGGER", "TRIGWORD"
	, "VALUE"	, "VETERINARY"	, "VULNERABLE"
	, "WATERWALK", "WRESTLING"
	]

allowedNpcAttrType= (
	2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,3,3,3,2,2,2,2,2	# A
	,5,2,2,2												# B
	,4,2,5,1,2,2,5,1,2										# C
	,2,1,2,2,2,2,0,1										# D
	,2,2
	,1,2,2,1,6,2,1,1,1,1,1									# F
	,2														#G
	,1,2,2,1,2,5											#H
	,4,2,2,2,5,1,2											# I
	,1														#K
	,5,2,1,1,3,2											#L
	,2,2,2,1,1,2,2,6,2										#M
	,0,1,5,1,1,1,1,1,1										#N
	,5,1,2,2,1,2,1,1,2										#P
	,1,1,1,1,1,2,2,3										#R
	,4,1,3,5,3,4,1,2,1,1,1,2,1,1,5,2,2,2,2,2				#S
	,2,2,2,2,2,0,1,1,2,1,0
	,1,2,5													#V
	,5,2
	)

allowedRaceAttributes=[
	"ALCHEMY",  "ANATOMY","ANIMALLORE", "ARCHERY", "ARMSLORE"
	, "BEARD", "BEARDCOLOR", "BEGGING", "BLACKSMITHING", "BOWCRAFTING"
	,"CAMPING","CARPENTRY","CARTOGRAPHY","COOKING"
	,"DESCRIPTION","DETECTHIDDEN","DEXCAP","DEXMOD","DEXSTART"
	,"ENEMY", "ENTICEMENT", "EVALUATEINTELLECT"
	,"FENCING","FISHING","FRIEND","FORENSICS"
	,"GENDER"
	,"HAIR","HAIRCOLOR", "HEALING", "HERDING",  "HIDING"
	,"INSCRIPTION", "INTCAP", "INTMOD", "INTSTART", "ITEMID"
	, "LOCKPICKING", "LUMBERJACKING"
	,"MACEFIGHTING", "MAGERY", "MAGICRESISTANCE","MAGICRESISTANT", "MEDITATION", "MINING", "MODE", "MUSICIANSHIP"
	, "NAME", "NEUTRAL"
	, "PEACEMAKING", "PLURALNAME", "POISONING", "POISONRESISTANCE", "PROVOCATION"
	, "RACETYPE", "REMOVETRAP"
	, "SKILLCAP", "SKINCOLOR", "SNOOPING", "SPIRITSPEAK", "STARTITEM", "STATCAP", "STEALING", "STEALTH", "STRCAP", "STRMOD", "STRSTART"
	, "SWORDMANSHIP"
	, "TACTICS", "TAMING", "TAILORING", "TASTEID", "TINKERING", "TILEID", "TRACKING"
	, "VETERINARY"
	, "WEBLINK", "WRESTLING"
	]

allowedHouseAttributes=[
	 "BOAT"
	,"CHARX","CHARY","CHARZ"
	, "HOUSE_ITEM", "HOUSE_DEED"
	,"ID", "ITEMSDECAY"
	, "NOREALMULTI", "NOKEY", "NAME"
	, "SPACEX", "SPACEY"
	]

allowedHouseItemAttributes=[
	"DECAY"
	,"ITEM"
	,"LOCK"
	,"MOVEABLE"
	,"NODECAY"
	,"X", "Y", "Z"
	]

allowedItemEvents= [
	"ONDAMAGE", "ONEQUIP","ONUNEQUIP","ONCLICK","ONDBLCLICK","ONPUTINBACKPACK","ONDROPINLAND","ONCHECKCANUSE","ONTRANSFER",
	"ONSTOLEN","ONPOISONED","ONDECAY","ONREMOVETRAP","ONLOCKPICK","ONWALKOVER","ONPUTITEM","ONTAKEFROMCONTAINER"
	]

allowedCharEvents=[
	"ONDEATH", "ONBEFOREDEATH", "ONWOUNDED", "ONHIT", "ONHITMISS", "ONGETHIT", "ONREPUTATIONCHG", "ONDISPEL", "ONRESURRECT"
	,"ONFLAGCHG", "ONWALK", "ONADVANCESKILL", "ONADVANCESTAT", "ONBEGINATTACK", "ONBEGINDEFENSE", "ONTRANSFER", "ONMULTIENTER"
	,"ONMULTILEAVE", "ONSNOOPED", "ONSTOLEN", "ONPOISONED", "ONREGIONCHANGE", "ONCASTSPELL", "ONGETSKILLCAP", "ONGETSTATCAP"
	,"ONBLOCK", "ONSTART", "ONHEARTBEAT", "ONBREAKMEDITATION", "ONCLICK", "ONMOUNT", "ONDISMOUNT", "ONKILL", "ONHEARPLAYER"
	,"ONDOCOMBAT", "ONCOMBATHIT", "ONSPEECH", "ONCHECKNPCAI", "ONDIED", "ONAFTERDEATH", "ONCREATION"
	]

true=1==1
false=0==1
def readNoxAccounts(nox_acc_file):
	if ( not os.path.isfile(nox_acc_file)):
		print "Datei ", nox_acc_file, "wurde nicht gefunden!"
		sys.exit(0)
	accFile = open (nox_acc_file)
	lineBuffer=accFile.readlines()
	lineindex=0
	while ( lineindex < len(lineBuffer)):
		line=lineBuffer[lineindex].strip()
		if ( line.startswith("SECTION ACCOUNT")):
			accNumber=line[line.index("ACCOUNT") + 8:].strip()
		if ( line.startswith("NAME")):
			glob.accNameTable[line[5:]] = accNumber
		lineindex+=1
	accFile.close()
	linebuffer=None

regExHexNumber=re.compile("^[0-9|A-F]+$", re.IGNORECASE)
regExPureDecimalNumber=re.compile("^[1-9][0-9]*$", re.IGNORECASE)

glob.files={}
glob.items={}
glob.npcs={}
glob.race={}
glob.house={}
glob.houseitem={}
glob.itemlists={}
glob.npclists={}
glob.lootlists={}
glob.namelists={}
glob.colorlists={}

def readNoxFile(filename):
	defaultName=None
	itemName=None
	bonusName=None
	if ( glob.files.has_key(os.path.abspath(filename))):
		return
	else:
		glob.files[os.path.abspath(filename)]=1
	if ( not os.path.isfile(filename)):
		print filename, "File does not exist"
		return
	itemFile = open( filename, "r")

	linebuffer = itemFile.readlines()
	lineindex=0
	glob.lastline=""
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex]
		if ( (line.endswith(" ") or line.endswith("	")) and len(line) > 1):
			if ( glob.warnings): print filename, "Warning: Trailing Whitespace in line", lineindex, line
			if ( glob.warnings): glob.errorfile.write(filename + "Warning: Trailing Whitespace in line " + str(lineindex) + ":" +  line+"\n")

		line=line.strip()
		#print "Line:", line
		if ( line == None or line == ""):
			pass
		elif ( line.startswith("#define")):
			fields=line.split()
			glob.symbolTable[fields[1]]=fields[2]
		elif ( line.startswith("//")):
			line =""
			pass
		elif ( line.startswith("SECTION ITEM ")):
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				glob.errorfile.write(filename+" Error: Found Section without preceding empty line in line" +  str(lineindex)+"\n")
			itemName=line[line.index("SECTION ITEM ")+len("SECTION ITEM "):].strip()
			if ( glob.phase == 1 and glob.items.has_key(itemName)):
				if ( glob.warnings): print filename, "Warning: Item", itemName, "at line", line, "has been defined in file",glob.items[itemName], "already"
				if ( glob.warnings): glob.errorfile.write(filename + "  Warning: Item" + itemName + "at line" + line + " has been defined in file " +glob.items[itemName] + " already"+"\n")
			else:
				glob.items[itemName]=filename
			if ( glob.phase == 2 ): lineindex = readItem(filename, linebuffer, lineindex, itemName)
		elif ( line.startswith("SECTION NPC ")):
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				if ( glob.warnings): glob.errorfile.write(filename + "  Error: Found Section without preceding empty line in line"+ str(lineindex) + "\n")
			npcName=line[line.index("SECTION NPC ")+len("SECTION NPC "):].strip()
			if ( glob.phase == 1 and glob.npcs.has_key(npcName)):
				if ( glob.warnings): print filename, "Warning: NPC", npcName, "at line", line, "has been defined in file",glob.npcs[npcName], "already"
				if ( glob.warnings): glob.errorfile.write(filename + "  Warning: NPC " + npcName + " at line" + line + " has been defined in file " +glob.npcs[npcName] + " already"+"\n")
			else:
				glob.npcs[npcName]=filename
			if ( glob.phase == 2 ): lineindex = readNpc(filename, linebuffer, lineindex, npcName)
		elif ( line.startswith("SECTION RACE ")):
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				if ( glob.warnings): glob.errorfile.write(filename + "  Error: Found Section without preceding empty line in line"+ str(lineindex) + "\n")
			name=line[line.index("SECTION RACE ")+len("SECTION RACE"):].strip()
			if ( glob.phase == 1 and glob.race.has_key(name)):
				if ( glob.warnings): print filename, "Warning: RACE", name, "at line", line, "has been defined in file",glob.race[name], "already"
				if ( glob.warnings): glob.errorfile.write(filename + "  Warning: RACE" + name + "at line" + line + " has been defined in file " +glob.race[name] + " already"+"\n")
			else:
				glob.race[name]=filename
			if ( glob.phase == 2 ): lineindex = readRace(filename, linebuffer, lineindex, name)
		elif ( line.startswith("SECTION RANDOMNAME ")):
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				if ( glob.warnings): glob.errorfile.write(filename + "  Error: Found Section without preceding empty line in line"+ str(lineindex) + "\n")
			defaultName=line[line.index("SECTION RANDOMNAME ")+len("SECTION RANDOMNAME "):].strip()
			if ( glob.phase == 1 and glob.namelists.has_key(defaultName)):
				if ( glob.warnings): print filename, "Warning: RANDOMNAME", defaultName, "at line", line, "has been defined in file",glob.namelists[defaultName], "already"
				if ( glob.warnings): glob.errorfile.write(filename + "  Warning: RANDOMNAME" + defaultName + "at line" + line + " has been defined in file " +glob.namelists[defaultName] + " already"+"\n")
			else:
				glob.namelists[defaultName]=filename
			if ( glob.phase == 2 ): lineindex = readRandomName(filename, linebuffer, lineindex, defaultName)
		elif ( line.startswith("SECTION HOUSE ITEM")):
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				if ( glob.warnings): glob.errorfile.write(filename + "  Error: Found Section without preceding empty line in line"+ str(lineindex) + "\n")
			houseName=line[line.index("SECTION HOUSE ITEM")+len("SECTION HOUSE ITEM"):].strip()
			if ( glob.phase == 1 and glob.houseitem.has_key(houseName)):
				if ( glob.warnings): print filename, "Warning: HOUSE ITEM", houseName, "at line", line, "has been defined in file",glob.houseitem[houseName], "already"
				if ( glob.warnings): glob.errorfile.write(filename + "  Warning: HOUSE ITEM" + houseName + "at line" + line + " has been defined in file " +glob.houseitem[houseName] + " already"+"\n")
			else:
				glob.houseitem[houseName]=filename
			lineindex = readHouseItem(filename, linebuffer, lineindex, houseName)
		elif ( line.startswith("SECTION HOUSE ")):
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				if ( glob.warnings): glob.errorfile.write(filename + "  Error: Found Section without preceding empty line in line"+ str(lineindex) + "\n")
			houseName=line[line.index("SECTION HOUSE ")+len("SECTION HOUSE"):].strip()
			if ( glob.phase == 1 and glob.house.has_key(houseName)):
				if ( glob.warnings): print filename, "Warning: HOUSE", houseName, "at line", line, "has been defined in file",glob.house[houseName], "already"
				if ( glob.warnings): glob.errorfile.write(filename + "  Warning: HOUSE" + houseName + "at line" + line + " has been defined in file " +glob.house[houseName] + " already"+"\n")
			else:
				glob.house[houseName]=filename
			if ( glob.phase == 2 ): lineindex = readHouse(filename, linebuffer, lineindex, houseName)
		elif ( line.startswith("SECTION ITEMLIST ")):
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				if ( glob.warnings): glob.errorfile.write(filename + "  Error: Found Section without preceding empty line in line"+ str(lineindex) + "\n")
			itemListName=line[line.index("SECTION ITEMLIST ")+len("SECTION ITEMLIST"):].strip()
			if ( glob.phase == 1 and glob.itemlists.has_key(itemListName)):
				if ( glob.warnings): print filename, "Warning: ITEMLIST", itemListName, "at line", line, "has been defined in file",glob.itemlists[itemListName], "already"
				if ( glob.warnings): glob.errorfile.write(filename + "  Warning: ITEMLIST" + itemListName + "at line" + line + " has been defined in file " +glob.itemlists[itemListName] + " already"+"\n")
			else:
				glob.itemlists[itemListName]=filename
			lineindex = readItemlist(filename, linebuffer, lineindex, itemListName)
		elif ( line.startswith("SECTION LOOTLIST ")):
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				if ( glob.warnings): glob.errorfile.write(filename + "  Error: Found Section without preceding empty line in line"+ str(lineindex) + "\n")
			name=line[line.index("SECTION LOOTLIST ")+len("SECTION LOOTLIST"):].strip()
			if ( glob.phase == 1 and glob.lootlists.has_key(name)):
				if ( glob.warnings): print filename, "ERROR: LOOTLIST", name, "at line", line, "has been defined in file",glob.lootlists[name], "already"
				if ( glob.warnings): glob.errorfile.write(filename + "  Error: LOOTLIST" + name + "at line" + line + " has been defined in file " +glob.lootlists[name] + " already"+"\n")
			else:
				glob.lootlists[name]=filename
			if ( glob.phase == 2 ): lineindex = readLootlist(filename, linebuffer, lineindex, name)
		elif ( line.startswith("SECTION NPCLIST ")):
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				if ( glob.warnings): glob.errorfile.write(filename + "  Error: Found Section without preceding empty line in line"+ str(lineindex) + "\n")
			name=line[line.index("SECTION NPCLIST ")+len("SECTION NPCLIST"):].strip()
			if (glob.phase == 1 and  glob.npclists.has_key(name)):
				if ( glob.warnings): print filename, "ERROR: NPCLIST", name, "at line", line, "has been defined in file",glob.items[itemName], "already"
				if ( glob.warnings): glob.errorfile.write(filename + "  Error: NPCLIST" + name + "at line" + line + " has been defined in file " +glob.items[itemName] + " already"+"\n")
			else:
				glob.npclists[name]=filename
			if ( glob.phase == 2 ): lineindex = readNpclist(filename, linebuffer, lineindex, name)
		elif ( line.startswith("SECTION RANDOMCOLOR ")):
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				if ( glob.warnings): glob.errorfile.write(filename + "  Error: Found Section without preceding empty line in line"+ str(lineindex) + "\n")
			defaultName=line[line.index("SECTION RANDOMCOLOR ")+len("SECTION RANDOMCOLOR "):].strip()
			if ( glob.phase == 1 and glob.colorlists.has_key(defaultName)):
				if ( glob.warnings): print filename, "Warning: RANDOMCOLOR", defaultName, "at line", line, "has been defined in file",glob.colorlists[defaultName], "already"
				if ( glob.warnings): glob.errorfile.write(filename + "  Warning: RANDOMCOLOR" + defaultName + "at line" + line + " has been defined in file " +glob.colorlists[defaultName] + " already"+"\n")
			else:
				glob.colorlists[defaultName]=filename
			if ( glob.phase == 2 ): lineindex = readRandomColor(filename, linebuffer, lineindex, defaultName)
		elif ( line.startswith("SECTION DEFAULT ")):
			if ( glob.debug): print "DEFAULT checking not yet implemented"
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				glob.errorfile.write(filename + "  Error: Found Section without preceding empty line in line"+ str(lineindex) + "\n")
			defaultName=line[line.index("SECTION DEFAULT ")+len("SECTION DEFAULT "):].strip()
			if ( glob.phase == 2 ): lineindex = readDefault(filename, linebuffer, lineindex, defaultName)
		elif ( line.startswith("SECTION BONUS ")):
			if ( glob.debug): print "BONUS checking not yet implemented"
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				glob.errorfile.write(filename + "  Error: Found Section without preceding empty line in line"+ str(lineindex) + "\n")
			bonusName=line[line.index("SECTION BONUS ")+len("SECTION BONUS"):].strip()
			if ( glob.phase == 2 ): lineindex = readBonus(filename, linebuffer, lineindex, bonusName)
		elif ( line.startswith("SECTION ITEMTRG ")):
			if ( glob.debug): print "ITEMTRG checking not yet implemented"
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				glob.errorfile.write(filename + "  Error: Found Section without preceding empty line in line"+ str(lineindex) + "\n")
			name=line[line.index("SECTION ITEMTRG ")+len("SECTION ITEMTRG"):].strip()
			if ( glob.phase == 2 ): lineindex = readItemTrigger(filename, linebuffer, lineindex, name)
		elif ( line.startswith("SECTION NPCTRG ")):
			if ( glob.debug): print "NPCTRG checking not yet implemented"
			if ( glob.lastline != "" ):
				print filename,"Error: Found Section without preceding empty line in line", lineindex
				glob.errorfile.write(filename + "  Error: Found Section without preceding empty line in line"+ str(lineindex) + "\n")
			name=line[line.index("SECTION NPCTRG ")+len("SECTION NPCTRG"):].strip()
			if ( glob.phase == 2 ): lineindex = readNpcTrigger(filename, linebuffer, lineindex, name)
		elif ( line.startswith("SECTION")):
			if ( glob.debug): print "Don't know what do to with SECTION", line[8:]
			while ( lineindex < len(linebuffer)):
				line = linebuffer[lineindex].strip()
				if ( line.startswith("}")):
					break
				else:
					lineindex +=1
		elif ( line.startswith("{")):
			if ( glob.phase == 2 ):
				print filename,"Error: Found { without SECTION start in line", lineindex
				glob.errorfile.write(filename + "  Error: Found { without SECTION start in line"+ str(lineindex) + "\n")

		elif ( line.startswith("}")):
			if ( glob.phase == 2 ):
				print filename,"Error: Found } without SECTION start in line", lineindex
				glob.errorfile.write(filename + "  Error: Found } without SECTION start in line"+ str(lineindex) + "\n")
		glob.lastline=line
		lineindex +=1

def readItem(filename, linebuffer, lineindex, itemname):

	if ( not glob.symbolTable.has_key(itemname)):
		print filename, "Error: Item", itemname, "has not been previously defined"
		glob.errorfile.write(filename + "  Error: Item" + itemname + " has not been previously defined"+"\n")
	lineindex+=1
	line = linebuffer[lineindex].strip()
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
		if ( glob.warnings): print filename,"Warning: Expected { in Item", itemname, ", but got", line, "in line", lineindex
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		commands=line.split();
		if ( line.find("//") > 0 ):
			# Remove comments
			line=line[0:line.find("//")].strip()
		if ( line == "" ):
			pass
		elif ( line.startswith("//") > 0 ):
			line =""
			pass
		elif (commands[0].strip() == "}"):
			return lineindex
		elif ( line.startswith("SECTION")):
			print filename,"Error: SECTION start in line", lineindex, "without closing }"
			glob.errorfile.write(filename + "  Error: SECTION start in line" + str (lineindex) + "without closing }"+"\n")
			return lineindex
		elif ( line.startswith("#copy") ):
			pass
			# Take a look if the copy section has already been defined
		elif ( line.startswith("@") ):
			eventlist=line.split()
			eventname=eventlist[0][1:]
			if ( not eventname in allowedItemEvents):
				if ( glob.warnings): print filename,"Warning: Unrecognized Event", eventname, "in item", itemname, "in line", lineindex, line
				glob.errorfile.write(filename + "  Error: Unrecognized Event" + eventname + "in item" + itemname + "in line" + str(lineindex) + line+"\n")
		elif ( not commands[0].strip().strip() in allowedItemAttributes ):
			if ( glob.warnings): print filename,"Warning: Unrecognized Attribute", commands[0].strip().strip(), "in item", itemname, "in line", lineindex, line
			glob.errorfile.write(filename + "  Error: Unrecognized Attribute" + commands[0].strip().strip() + "in item" + itemname + "in line" + str(lineindex) + line+"\n")
		elif ( commands[0].strip().strip() in allowedItemAttributes ):
			cmdIndex=allowedItemAttributes.index(commands[0].strip().strip())

			# print "Found", cmdIndex, "for", commands[0].strip(), "with type", allowedItemAttrType[cmdIndex]
			if ( len(allowedItemAttrType) > cmdIndex ):
				argumentType=allowedItemAttrType[cmdIndex]
				if ( argumentType == 0 ):
					# String type
					if ( len(commands) <= 1 ):
						print filename, "Error: Expected argument for", commands[0].strip(), "in line", lineindex
						glob.errorfile.write(filename + "  Error: Expected argument for" + commands[0].strip() + "in line"+ str(lineindex) + "\n")
				elif ( argumentType == 1 ):
					# Numeric or symbol, single value
					if ( len(commands) <= 1 ):
						print filename, "Error: Expected argument for", commands[0].strip(), "in line", lineindex
						glob.errorfile.write(filename + "  Error: Expected argument for" + commands[0].strip() + "in line"+ str(lineindex) + "\n")
					elif ( len(commands) > 2 ):
						print filename, "Error: Too many arguments for", commands[0].strip(), "in line", lineindex
						glob.errorfile.write(filename + "  Error: Too many arguments for" + commands[0].strip() + "in line"+ str(lineindex) + "\n")
					else:
						if ( commands[1].strip().startswith("$") ):
							if ( not glob.symbolTable.has_key(commands[1].strip())):
								print filename, "Error: Symbol", commands[1].strip(), "has not been previously defined in item", itemname, "in line", lineindex
								glob.errorfile.write(filename + "  Error: Symbol" + commands[1].strip() + " has not been previously defined in item" + itemname + "in line"+ str(lineindex) + "\n")
							elif ( commands[0].strip() == "ITEMLIST" and not glob.itemlists.has_key(commands[1].strip())):
								print filename, "Error: Symbol", commands[1].strip(), "referenced from  item", itemname, "in line", lineindex, "but has not been defined yet !"
								glob.errorfile.write(filename + " Error: Symbol " + commands[1].strip() + " referenced from  item " + itemname + "in line"+ str(lineindex) + " but has not been defined yet !\n")
							elif ( commands[0].strip() == "CONTAINS" and not glob.items.has_key(commands[1].strip())):
									print filename, "Error: Symbol", commands[1].strip(), "referenced from  item", itemname, "in line", lineindex, "but has not been defined yet !"
									glob.errorfile.write(filename + " Error: Symbol " + commands[1].strip() + " referenced from  item " + itemname + "in line"+ str(lineindex) + " but has not been defined yet !\n")
							elif ( commands[0].strip() == "CONTAINLIST" and not glob.itemlists.has_key(commands[1].strip())):
									print filename, "Error: Symbol", commands[1].strip(), "referenced from  item", itemname, "in line", lineindex, "but has not been defined yet !"
									glob.errorfile.write(filename + " Error: Symbol " + commands[1].strip() + " referenced from  item " + itemname + "in line"+ str(lineindex) + " but has not been defined yet !\n")

						else:
							# check for numeric value
							try:
								value=long(commands[1].strip())
							except:
								print filename, "Error: Value", commands[1].strip(), "is non numeric in item", itemname, "in line", lineindex
								glob.errorfile.write(filename + "  Error: Value " + commands[1].strip() + " is non numeric in item" + itemname + "in line"+ str(lineindex) + "\n")
				elif ( argumentType == 2 ):
					# Numeric or symbol, single value
					if ( len(commands) <= 1 ):
						print filename, "Error: Expected ranged argument for", commands[0].strip(), "in line", lineindex
						glob.errorfile.write(filename + "  Error: Expected ranged argument for" + commands[0].strip() + "in line"+ str(lineindex) + "\n")
					elif ( len(commands) > 3 ):
						print filename, "Error: Too many arguments for", commands[0].strip(), "in line", lineindex
						glob.errorfile.write(filename + "  Error: Too many arguments for" + commands[0].strip() + "in line"+ str(lineindex) + "\n")
					else:
						if ( commands[1].strip().startswith("$") ):
							if ( not glob.symbolTable.has_key(commands[1].strip())):
								print filename, "Error: Symbol", commands[1].strip(), "has not been previously defined in item", itemname, "in line", lineindex
								glob.errorfile.write(filename + "  Error: Symbol" + commands[1].strip() + " has not been previously defined in item" + itemname + "in line"+ str(lineindex) + "\n")
						else:
							# check for numeric value
							try:
								value=long(commands[1].strip())
							except:
								print filename, "Error: Value", commands[1].strip(), "is non numeric in item", itemname, "in line", lineindex
								glob.errorfile.write(filename + "  Error: Value " + commands[1].strip() + " is non numeric in item" + itemname + "in line"+ str(lineindex) + "\n")
						if ( len(commands) > 2 ):
							if ( commands[2].strip().startswith("$") ):
								if ( not glob.symbolTable.has_key(commands[2].strip())):
									print filename, "Error: Symbol", commands[2].strip(), "has not been previously defined in item", itemname, "in line", lineindex
									glob.errorfile.write(filename + "  Error: Symbol" + commands[2].strip() + " has not been previously defined in item" + itemname + "in line"+ str(lineindex) + "\n")
							else:
								# check for numeric value
								try:
									value=long(commands[2].strip())
								except:
									print filename, "Error: Value", commands[2].strip(), "is non numeric in item", itemname, "in line", lineindex
									glob.errorfile.write(filename + "  Error: Value " + commands[2].strip() + " is non numeric in item" + itemname + "in line"+ str(lineindex) + "\n")
		else:
			pass
			# Put in argument checking later in here
		glob.lastline=line
		lineindex +=1
	return lineindex

def readNpc(filename, linebuffer, lineindex, npcname):

	if ( not glob.symbolTable.has_key(npcname)):
		print filename, "Error: NPC", itemname, "has not been previously defined as a symbol name"
		glob.errorfile.write(filename + "  Error: NPC" + itemname + " has not been previously defined as a symbol name"+"\n")
	lineindex+=1
	line = linebuffer[lineindex].strip()
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
		if ( glob.warnings): print filename,"Warning: Expected { in NPC", npcname, ", but got", line, "in line", lineindex
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		commands=line.split();
		if ( line == "" ):
			pass
		elif ( line.startswith("//") > 0 ):
			line =""
			pass
		elif (commands[0].strip() == "}"):
			return lineindex
		elif ( line.startswith("SECTION")):
			print filename,"Error: SECTION start in line", lineindex, "without closing }"
			glob.errorfile.write(filename + "  Error: SECTION start in line" + str (lineindex) + "without closing }"+"\n")
		elif ( line.startswith("@") ):
			eventlist=line.split()
			eventname=eventlist[0][1:]
			if ( not eventname in allowedCharEvents):
				if ( glob.warnings): print filename,"Warning: Unrecognized Event", eventname, "in npc", npcname, "in line", lineindex, line
				glob.errorfile.write(filename + "  Warning: Unrecognized Event" + eventname + "in npc " + npcname + " in line" + str(lineindex) + ":" + line+"\n")
		elif ( not commands[0].strip() in allowedCharAttributes ):
			if ( glob.warnings): print filename,"Warning: Unrecognized Attribute", commands[0].strip(), "in npc", npcname, "in line", lineindex, line
			glob.errorfile.write(filename + "  Warning: Unrecognized Attribute" + commands[0].strip() + "in npc " + npcname + " in line" + str(lineindex)+ ":" + line+"\n")
		elif ( commands[0].strip() in allowedNpcAttrType ):
			cmdIndex=allowedNpcAttrType.index(commands[0].strip())

			# print "Found", cmdIndex, "for", commands[0].strip(), "with type", allowedItemAttrType[cmdIndex]
			if ( len(allowedNpcAttrType) > cmdIndex ):
				argumentType=allowedNpcAttrType[cmdIndex]
				if ( argumentType == 0 ):
					# String type
					if ( len(commands) <= 1 ):
						print filename, "Error: Expected argument for", commands[0].strip(), "in line", lineindex
						glob.errorfile.write(filename + "  Error: Expected argument for" + commands[0].strip() + "in line"+ str(lineindex) + "\n")
				elif ( argumentType == 1 ):
					# Numeric or symbol, single value
					if ( len(commands) <= 1 ):
						print filename, "Error: Expected argument for", commands[0].strip(), "in line", line
						glob.errorfile.write(filename + " Error: Expected argument for" + commands[0].strip() + "in line" + line+"\n")
					elif ( len(commands) > 2 ):
						print filename, "Error: Too many arguments for", commands[0].strip(), "in line", line
						glob.errorfile.write(filename + " Error: Too many arguments for" + commands[0].strip() + "in line" + line+"\n")
					else:
						if ( commands[1].strip().startswith("$") ):
							if ( not glob.symbolTable.has_key(commands[1].strip())):
								print filename, "Error: Symbol", commands[1].strip(), "has not been previously defined in npc", npcname, "in line", str(lineindex)
								glob.errorfile.write(filename + " Error: Symbol" + commands[1].strip() + " has not been previously defined in npc " + npcname + " in line" + str(lineindex)+"\n")
							elif ( commands[0].strip() == "COLORLIST" and not glob.colorlists.has_key(commands[1].strip())):
								print filename, "Error: Symbol", commands[1].strip(), "referenced from  item", itemname, "in line", lineindex, "but has not been defined yet !"
								glob.errorfile.write(filename + " Error: Symbol " + commands[1].strip() + " referenced from  item " + itemname + "in line"+ str(lineindex) + " but has not been defined yet !\n")
							elif ( commands[0].strip() == "ITEM" and not glob.items.has_key(commands[1].strip())):
								print filename, "Error: Symbol", commands[1].strip(), "referenced from  item", itemname, "in line", lineindex, "but has not been defined yet !"
								glob.errorfile.write(filename + " Error: Symbol " + commands[1].strip() + " referenced from  item " + itemname + "in line"+ str(lineindex) + " but has not been defined yet !\n")
							elif ( commands[0].strip() == "LOOT" and not glob.lootlists.has_key(commands[1].strip())):
								print filename, "Error: Symbol", commands[1].strip(), "referenced from  item", itemname, "in line", lineindex, "but has not been defined yet !"
								glob.errorfile.write(filename + " Error: Symbol " + commands[1].strip() + " referenced from  item " + itemname + "in line"+ str(lineindex) + " but has not been defined yet !\n")
							elif ( commands[0].strip() == "LOOTITEM" and not glob.lootlists.has_key(commands[1].strip())):
								print filename, "Error: Symbol", commands[1].strip(), "referenced from  item", itemname, "in line", lineindex, "but has not been defined yet !"
								glob.errorfile.write(filename + " Error: Symbol " + commands[1].strip() + " referenced from  item " + itemname + "in line"+ str(lineindex) + " but has not been defined yet !\n")
							elif ( commands[0].strip() == "NAMELIST" and not glob.randomnames.has_key(commands[1].strip())):
								print filename, "Error: Symbol", commands[1].strip(), "referenced from  item", itemname, "in line", lineindex, "but has not been defined yet !"
								glob.errorfile.write(filename + " Error: Symbol " + commands[1].strip() + " referenced from  item " + itemname + "in line"+ str(lineindex) + " but has not been defined yet !\n")
						else:
							# check for numeric value
							try:
								value=long(commands[1].strip())
							except:
								print filename, "Error: Value", commands[1].strip(), "is non numeric in npc", npcname, "in line", str(lineindex)
								glob.errorfile.write(filename + " Error: Value " + commands[1].strip() + " is non numeric in npc " + npcname + " in line" + str(lineindex)+"\n")
				elif ( argumentType == 2 ):
					# Numeric or symbol, single value
					if ( len(commands) <= 1 ):
						print filename, "Error: Expected ranged argument for", commands[0].strip(), "in line", str(lineindex)
						glob.errorfile.write(filename + " Error: Expected ranged argument for" + commands[0].strip() + "in line" + str(lineindex)+"\n")
					elif ( len(commands) > 3 ):
						print filename, "Error: Too many arguments for", commands[0].strip(), "in line", str(lineindex)
						glob.errorfile.write(filename + " Error: Too many arguments for" + commands[0].strip() + "in line" + str(lineindex)+"\n")
					else:
						if ( commands[1].strip().startswith("$") ):
							if ( not glob.symbolTable.has_key(commands[1].strip())):
								print filename, "Error: Symbol", commands[1].strip(), "has not been previously defined in npc", npcname, "in line", str(lineindex)
								glob.errorfile.write(filename + "  Error: Symbol " + commands[1].strip() + " has not been previously defined in npc " + npcname + " in line" + str(lineindex)+"\n")
						else:
							# check for numeric value
							try:
								value=long(commands[1].strip())
							except:
								print filename, "Error: Value", commands[1].strip(), "is non numeric in npc", npcname, "in line", str(lineindex)
								glob.errorfile.write(filename + " Error: Value " + commands[1].strip() + " is non numeric in npc " + npcname + " in line" + str(lineindex)+"\n")
						if ( len(commands) > 2 ):
							if ( commands[2].strip().startswith("$") ):
								if ( not glob.symbolTable.has_key(commands[2].strip())):
									print filename, "Error: Symbol", commands[2].strip(), "has not been previously defined in npc", npcname, "in line", str(lineindex)
									glob.errorfile.write(filename + "  Error: Symbol " + commands[2].strip() + " has not been previously defined in npc  " + npcname + "  in line " + str(lineindex)+"\n")
							else:
								# check for numeric value
								try:
									value=long(commands[2].strip())
								except:
									print filename, "Error: Value", commands[2].strip(), "is non numeric in npc", npcname, "in line", str(lineindex)
									glob.errorfile.write(filename + " Error: Value " + commands[2].strip() + " is non numeric in npc " + npcname + " in line " + str(lineindex)+"\n")
		else:
			pass
			# Put in argument checking later in here
		glob.lastline=line
		lineindex +=1
	return lineindex

def readRace(filename, linebuffer, lineindex, racename):

	if ( racename.startswith("$") and not glob.symbolTable.has_key(racename)):
		print filename, "Error: Race", racename, "has not been previously defined as a symbol name"
	glob.errorfile.write(filename + "  Error: Race" + racename + " has not been previously defined as a symbol name"+"\n")
	lineindex+=1
	line = linebuffer[lineindex].strip()
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
			if ( glob.warnings): print filename,"Warning: Expected { in NPC", npcname, ", but got", line
			if ( glob.warnings): glob.errorfile.write(filename +"Warning: Expected { in NPC " + npcname + "  + but got" + line+"\n")
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		commands=line.split();
		if ( line == "" ):
			pass
		elif ( line.startswith("//") > 0 ):
			line =""
			pass
		elif ( line.startswith("#copy") ):
			pass
		elif (commands[0].strip() == "}"):
			return lineindex
		elif ( line.startswith("SECTION")):
			print filename,"Error: SECTION start in line", lineindex, "without closing }"
			glob.errorfile.write(filename + "  Error: SECTION start in line" + str (lineindex) + "without closing }"+"\n")
		elif ( not commands[0].strip() in allowedRaceAttributes ):
			print filename,"Error: Unrecognized Attribute", commands[0].strip(), "in race", racename, "in line", lineindex, line
			glob.errorfile.write(filename + "  Error: Unrecognized Attribute " + commands[0].strip() + " in race " + racename + " in line " + str(lineindex) + " " + line+"\n")
		elif ( commands[0].strip() in allowedRaceAttributes ):
			pass
			# Put in argument checking later in here
		glob.lastline=line
		lineindex +=1
	return lineindex

#RANDOMNAME is just overread since it consists only of names, but empty lines are an error

def readRandomName(filename, linebuffer, lineindex, namelist):
	lineindex+=1
	line = linebuffer[lineindex].strip()
	if ( not glob.symbolTable.has_key(namelist)):
		print filename, "Error: NAMELIST", namelist, "has not been previously defined as a symbol name"
		glob.errorfile.write(filename + "  Error: NAMELIST" + namelist + " has not been previously defined as a symbol name"+"\n")
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
		if ( glob.warnings):
			print filename,"Warning: Expected { in NAMELIST", namelist, ", but got", line, "in line", lineindex
			glob.errorfile.write(filename +"Warning: Expected { in NAMELIST" + namelist + " + but got" + line+"\n")
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		if ( line == "" ):
			print filename,"Error: Found empty line in NAMELIST", namelist, "in line", lineindex
			glob.errorfile.write(filename + "  Error: Found empty line in NAMELIST" + namelist + "in line" + lineinddex+"\n")
		elif ( line.startswith("//") > 0 ):
			line =""
		elif (line == "}"):
			return lineindex
		glob.lastline=line
		lineindex +=1
	return lineindex

def readRandomColor(filename, linebuffer, lineindex, namelist):
	lineindex+=1
	line = linebuffer[lineindex].strip()
	if ( not glob.symbolTable.has_key(namelist)):
		print filename, "Error: RANDOMCOLOR", namelist, "has not been previously defined as a symbol name"
		glob.errorfile.write(filename + "  Error: RANDOMCOLOR" + namelist + " has not been previously defined as a symbol name"+"\n")
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
		if ( glob.warnings):
			print filename,"Warning: Expected { in RANDOMCOLOR", namelist, ", but got", line, "in line", lineindex
			glob.errorfile.write(filename +"Warning: Expected { in RANDOMCOLOR" + namelist + " + but got" + line+"\n")
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		if ( line == "" ):
			print filename,"Error: Found empty line in RANDOMCOLOR", namelist, "in line", lineindex
			glob.errorfile.write(filename + "  Error: Found empty line in RANDOMCOLOR" + namelist + "in line" + lineinddex+"\n")
		elif ( line.startswith("//") > 0 ):
			line =""
		elif (line == "}"):
			return lineindex
		glob.lastline=line
		lineindex +=1
	return lineindex

def readHouseItem(filename, linebuffer, lineindex, itemname):
	lineindex+=1
	line = linebuffer[lineindex].strip()
	if ( itemname.startswith("$") and not glob.symbolTable.has_key(itemname)):
		print filename, "Error: House item", itemname, "has not been previously defined as a symbol name"
		glob.errorfile.write(filename + "  Error: House item" + itemname + " has not been previously defined as a symbol name"+"\n")
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
		if ( glob.warnings):
			print filename,"Warning: Expected { in HOUSE ITEM", itemname, ", but got", line, "in line", lineindex
			glob.errorfile.write(filename +"Warning: Expected { in HOUSE ITEM" + itemname + " + but got" + line+"\n")
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		commands=line.split();
		if ( line == "" ):
			pass
		elif ( line.startswith("//") > 0 ):
			line =""
			pass
		elif (commands[0].strip() == "}"):
			return lineindex
		elif ( line.startswith("SECTION")):
			print filename,"Error: SECTION start in line", lineindex, "without closing }"
			glob.errorfile.write(filename + "  Error: SECTION start in line" + str (lineindex) + "without closing }"+"\n")
		elif ( not commands[0].strip() in allowedHouseItemAttributes ):
			print filename,"Error: Unrecognized Attribute", commands[0].strip(), "in house", itemname, "in line", lineindex, line
			glob.errorfile.write(filename + "  Error: Unrecognized Attribute" + commands[0].strip() + "in house" + itemname + "in line" + str (lineindex) + line+"\n")
		elif ( commands[0].strip() in allowedHouseItemAttributes ):
			pass
			# Put in argument checking later in here
		glob.lastline=line
		lineindex +=1
	return lineindex


def readHouse(filename, linebuffer, lineindex, housename):
	lineindex+=1
	line = linebuffer[lineindex].strip()
	if ( housename.startswith("$") and not glob.symbolTable.has_key(housename)):
		print filename, "Error: House ", housename, "has not been previously defined as a symbol name"
	glob.errorfile.write(filename + "  Error: House " + housename + " has not been previously defined as a symbol name"+"\n")
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
		if ( glob.warnings):
			print filename,"Warning: Expected { in HOUSE", housename, ", but got", line, "in line", lineindex
			glob.errorfile.write(filename +"Warning: Expected { in HOUSE" + housename + " + but got" + line+"\n")
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		commands=line.split();
		if ( line == "" ):
			pass
		elif ( line.startswith("//") > 0 ):
			line =""
			pass
		elif (commands[0].strip() == "}"):
			return lineindex
		elif ( line.startswith("SECTION")):
			print filename,"Error: SECTION start in line", lineindex, "without closing }"
			glob.errorfile.write(filename + "  Error: SECTION start in line" + str (lineindex) + "without closing }"+"\n")
		elif ( not commands[0].strip() in allowedHouseAttributes ):
			print filename,"Error: Unrecognized Attribute", commands[0].strip(), "in house", housename, "in line", lineindex, line
			glob.errorfile.write(filename + "  Error: Unrecognized Attribute" + commands[0].strip() + "in house" + housename + "in line" + str (lineindex) + line+"\n")
		elif ( commands[0].strip() in allowedHouseAttributes ):
			pass
			# Put in argument checking later in here
		glob.lastline=line
		lineindex +=1
	return lineindex

def readItemlist(filename, linebuffer, lineindex, itemListName):
	lineindex+=1
	line = linebuffer[lineindex].strip()
	if ( itemListName.startswith("$") and not glob.symbolTable.has_key(itemListName)):
		print filename, "Error: ITEMLIST ", itemListName, "has not been previously defined as a symbol name"
		glob.errorfile.write(filename + "  Error: ITEMLIST " + itemListName + " has not been previously defined as a symbol name"+"\n")
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
		if ( glob.warnings):
			print filename,"Warning: Expected { in ITEMLIST", itemListName, ", but got", line, "in line", lineindex
			glob.errorfile.write(filename +"Warning: Expected { in ITEMLIST" + itemListName + " + but got" + line+"\n")
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		if ( line == "" ):
			print filename,"Error: Found empty line in ITEMLIST", itemListName, "in line", lineindex
			glob.errorfile.write(filename + "  Error: Found empty line in ITEMLIST" + itemListName + "in line"+ str(lineindex) + "\n")
		elif ( line.startswith("//") > 0 ):
			line =""
		if ( line.find("//") > 0 ):
			# Remove comments
			line=line[0:line.find("//")].strip()
		elif (line == "}"):
			return lineindex
		else:
			# the rest must be defined as a symbol
			if ( line.startswith("$") and not glob.symbolTable.has_key(line)):
				print filename, "Error: ITEM  ", line, "in itemlist", itemListName, "has not been previously defined as a symbol name in line", lineindex
				glob.errorfile.write(filename + "  Error: ITEM  " + line + "in itemlist" + itemListName + " has not been previously defined as a symbol name in line" + str(lineindex)+"\n")

		glob.lastline=line
		lineindex +=1
	return lineindex

def readLootlist(filename, linebuffer, lineindex, lootlistName):
	lineindex+=1
	line = linebuffer[lineindex].strip()
	if ( lootlistName.startswith("$") and not glob.symbolTable.has_key(lootlistName)):
		print filename, "Error: LOOTLIST ", lootlistName, "has not been previously defined as a symbol name"
		glob.errorfile.write(filename + "  Error: LOOTLIST " + lootlistName + " has not been previously defined as a symbol name"+"\n")
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
		if ( glob.warnings):
			print filename,"Warning: Expected { in LOOTLIST", lootlistName, ", but got", line, "in line", lineindex
			glob.errorfile.write(filename +"Warning: Expected { in LOOTLIST" + lootlistName + " + but got" + line+"\n")
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		if ( line == "" ):
			print filename,"Error: Found empty line in LOOTLIST", lootlistName, "in line", lineindex
			glob.errorfile.write(filename + "  Error: Found empty line in LOOTLIST" + lootlistName + "in line"+ str(lineindex) + "\n")
		elif ( line.startswith("//") > 0 ):
			line =""
		if ( line.find("//") > 0 ):
			# Remove comments
			line=line[0:line.find("//")].strip()
		elif (line == "}"):
			return lineindex
		else:
			# the rest must be defined as a symbol
			if ( line.startswith("$") and not glob.symbolTable.has_key(line)):
				print filename, "Error: ", line, "in lootlist", lootlistName, "has not been previously defined as a symbol name in line", lineindex
				glob.errorfile.write(filename + "  Error: " + line + "in lootlist" + lootlistName + " has not been previously defined as a symbol name in line"+ str(lineindex) + "\n")

		glob.lastline=line
		lineindex +=1
	return lineindex

def readNpclist(filename, linebuffer, lineindex, listName):
	lineindex+=1
	line = linebuffer[lineindex].strip()
	if ( listName.startswith("$") and not glob.symbolTable.has_key(listName)):
		print filename, "Error: NPCLIST ", listName, "has not been previously defined as a symbol name"
		glob.errorfile.write(filename + "  Error: NPCLIST " + listName + " has not been previously defined as a symbol name"+"\n")
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
		if ( glob.warnings):
			print filename,"Warning: Expected { in NPCLIST", listName, ", but got", line, "in line", lineindex
			glob.errorfile.write(filename +"Warning: Expected { in NPCLIST" + listName + " + but got" + line+"\n")
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		if ( line == "" ):
			print filename,"Error: Found empty line in NPCLIST", listName, "in line", lineindex
			glob.errorfile.write(filename + "  Error: Found empty line in NPCLIST" + listName + "in line"+ str(lineindex) + "\n")
		elif ( line.startswith("//") > 0 ):
			line =""
		if ( line.find("//") > 0 ):
			# Remove comments
			line=line[0:line.find("//")].strip()
		elif (line == "}"):
			return lineindex
		else:
			# the rest must be defined as a symbol
			if ( line.startswith("$") and not glob.symbolTable.has_key(line)):
				print filename, "Error: ", line, "in NPCLIST", listName, "has not been previously defined as a symbol name in line", lineindex
				glob.errorfile.write(filename + "  Error: " + line + "in NPCLIST" + listName + " has not been previously defined as a symbol name in line"+ str(lineindex) + "\n")

		glob.lastline=line
		lineindex +=1
	return lineindex


def readBonus(filename, linebuffer, lineindex, bonusname):
	lineindex+=1
	line = linebuffer[lineindex].strip()
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
		if ( glob.warnings):
			print filename,"Warning: Expected { in BONUS", bonusname, ", but got", line, "in line", lineindex
			glob.errorfile.write(filename +"Warning: Expected { in BONUS" + bonusname + " + but got" + line+"\n")
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		if ( line == "" ):
			pass
		elif ( line.startswith("//") > 0 ):
			line =""
		elif (line == "}"):
			return lineindex
		glob.lastline=line
		lineindex +=1
	return lineindex

def readDefault(filename, linebuffer, lineindex, defaultname):
	lineindex+=1
	line = linebuffer[lineindex].strip()
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
		if ( glob.warnings):
			print filename,"Warning: Expected { in DEFAULT", defaultname, ", but got", line, "in line", lineindex
			glob.errorfile.write(filename +"Warning: Expected { in DEFAULT" + defaultname + " + but got" + line+"\n")
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		if ( line == "" ):
			pass
		elif ( line.startswith("//") > 0 ):
			line =""
		elif (line == "}"):
			return lineindex
		glob.lastline=line
		lineindex +=1
	return lineindex


def readItemTrigger(filename, linebuffer, lineindex, triggerName):
	lineindex+=1
	line = linebuffer[lineindex].strip()
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
		if ( glob.warnings):
			print filename,"Warning: Expected { in ITEMTRIGGER", triggerName, ", but got", line, "in line", lineindex
			glob.errorfile.write(filename +"Warning: Expected { in ITEMTRIGGER" + triggerName + " + but got" + line+"\n")
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		if ( line == "" ):
			pass
		elif ( line.startswith("//") > 0 ):
			line =""
		glob.lastline=line
		lineindex +=1
	return lineindex

def readNpcTrigger(filename, linebuffer, lineindex, triggerName):
	lineindex+=1
	line = linebuffer[lineindex].strip()
	while ( line.startswith("//") > 0 ):
		# Remove comments
		lineindex+=1
		line=linebuffer[lineindex].strip()
	if ( line.find("//") > 0 ):
		# Remove comments
		line=line[0:line.find("//")].strip()
	if ( line != "{" ):
		if ( glob.warnings):
			print filename,"Warning: Expected { in NPCTRIGGER", triggerName, ", but got", line, "in line", lineindex
			glob.errorfile.write(filename +"Warning: Expected { in NPCTRIGGER" + triggerName + " + but got" + line+"\n")
	lineindex+=1
	glob.lastline=line
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		if ( line == "" ):
			pass
		elif ( line.startswith("//") > 0 ):
			line =""
		elif (line == "}"):
			return lineindex
		glob.lastline=line
		lineindex +=1
	return lineindex

def readNoxItems(noxScriptsDir):
	if ( not os.path.isdir(noxScriptsDir)):
		print "Verzeichnis " + noxScriptsDir + " nicht gefunden!"
		sys.exit(0)
	if ( not noxScriptsDir.endswith("/")):
		noxScriptsDir += "/"
	noxItemDir=noxScriptsDir + "items/"

# Reading scripts/*.xss for includes first
	dirList=os.listdir(noxScriptsDir)
	workList=[]
	for dirElem in dirList:
		if ( dirElem.endswith(".xss")):
			itemFile = open( noxScriptsDir + "/" + dirElem, "r")
			linebuffer = itemFile.readlines()
			lineindex=0
			while (lineindex < len(linebuffer) ):
				line = linebuffer[lineindex]
				if ( line != None and line.upper().strip().startswith("#INCLUDE")):
					includeFile=linebuffer[lineindex][line.upper().find("#INCLUDE")+len("#INCLUDE")+1:len(line)]
					if ( includeFile.find("\n") > 0 ):
						includeFile=includeFile[0:includeFile.find("\n")]
					includeFile=os.path.abspath(noxScriptsDir + "/../"+includeFile)
					if ( includeFile not in workList ):
						workList.append(includeFile)
				lineindex +=1
	dirContent=["./"]

	while ( len(dirContent) > 0 ):
		curDir = dirContent[0]
		del dirContent[0]
		dirList=os.listdir(noxItemDir + curDir)
		for dirElem in dirList:
			if ( dirElem.endswith(".xss") and os.path.abspath(noxItemDir + curDir + "/" + dirElem) not in workList):
				workList.append(os.path.abspath(noxItemDir + curDir + "/" + dirElem))
			if os.path.isdir(noxItemDir + curDir + "/" + dirElem):
				dirContent.append(curDir + "/" + dirElem)

	ruleCounter=0
	glob.noxItemRules={}
	glob.noxDefaultRules={}
	glob.noxBonusRules={}
	for file in workList:
		readNoxFile(file)
	return

def loadSymbols(noxSymbolDir):
	if ( not os.path.isdir(noxSymbolDir)):
		print "Verzeichnis " + noxSymbolDir + " nicht gefunden!"
		sys.exit(0)
	if ( not noxSymbolDir.endswith("/")):
		noxSymbolDir += "/"
	dirContent=["./"]
	workList=[]
	defaultName=None
	itemName=None

	while ( len(dirContent) > 0 ):
		curDir = dirContent[0]
		del dirContent[0]
		dirList=os.listdir(noxSymbolDir + curDir)
		for dirElem in dirList:
			if ( dirElem.endswith(".xss")):
				workList.append(noxSymbolDir + curDir + "/" + dirElem)
			if os.path.isdir(noxSymbolDir + curDir + "/" + dirElem):
				dirContent.append(curDir + "/" + dirElem)
	for file in workList:
		symbolFile = open 	( file, "r")
		lineBuffer = symbolFile.readlines()
		symbolFile.close()
		for line in lineBuffer:
			if ( line.startswith("#define")):
				fields=line.split()
				glob.symbolTable[fields[1]]=fields[2]

def usage():
	print "Usage:"
	print "xsschecker.py -d <Full Path> "
	print "-d <Nox Directory> : 	the path (without filename) of the nox wizard directory"
	print "-D                         : 	Turn on debug mode"
	print "-W                         : 	Turn on warnings"

def main():
# Initializing variables

	glob.accNameTable={}
	glob.translationRules={}
	targetfile=""
	sourcedir=""
	noxItemDir=None
	glob.lineCount=0
	noxScriptsDir=""
	glob.itemArray=[]
	glob.symbolTable={}
	glob.noxMissing={}
	glob.debug=0
	glob.warnings=0
	print "Nox Wizard 0.82 XSS verifier"
	print "This program was conceived and written by Straylight of the Ultima Online freeshard Anacron, http://anacron.confused.at/"
	print "Report bugs or enhancement requests to straylight@anacron-staff.de"
# argument test
	if ( len(sys.argv) < 2 ):
		usage()
		sys.exit()
	if ( sys.argv[1] == None or sys.argv[1]=="" ):
		usage()
		sys.exit();
# argument eval
	opts, args = getopt.getopt(sys.argv[1:], "d:hDW")
	for opt, arg in opts:
		if opt == "-h":
			usage()
			sys.exit()
		if opt == "-d":
			noxScriptsDir=arg
			if ( not os.path.isdir(noxScriptsDir)):
				print "Nox Scripts Directory does not exist or is not a directory!"
				sys.exit()
		if opt == "-D":
			glob.debug=1
		if opt == "-W":
			glob.warnings=1
	if ( noxScriptsDir == None):
		print "No Nox scripts dir given"
		usage()
		sys.exit()
# Initializing file buffers
	glob.errorfile=open (os.path.dirname(sys.argv[0]) + "/" + "errors.log", "w")

# Initializign account index
	print "Initializing..."
# Initializing Itemvalues
	print "Pass 1: Checking syntax of xss files..."
	print "Reading nox wizard symbol files...",
	loadSymbols(noxScriptsDir)
	print "Done"
	print "Verifying nox wizard xss files..."
	glob.phase=1
	readNoxItems(noxScriptsDir )
	print "Done"
	print "Pass 2: Checking references..."
	glob.phase=2
	glob.files={}
	readNoxItems(noxScriptsDir )
	print "Done"

	print "Closing files...",

	glob.errorfile.close()
	print "Done"
	print "Removing temporary files...",
	print "Done"

main()