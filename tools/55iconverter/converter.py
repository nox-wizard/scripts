#!/usr/bin/python
# -*- coding: utf-8 -*-

# This tool was conceived and written by Wintermute


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

def readNoxFile(filename):
	defaultName=None
	itemName=None
	bonusName=None
	itemFile = open( filename, "r")
	linebuffer = itemFile.readlines()
	lineindex=0
	currentRule=""
	rules=[]
	priv=0
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		#print "Line:", line
		if ( line == None or line == ""):
			lineindex +=1
			continue
		if ( line.startswith("#define")):
			fields=line.split()
			glob.symbolTable[fields[1]]=fields[2]
			lineindex +=1
			continue
		if ( line.startswith("//")):
			lineindex +=1
			continue

		if ( line.startswith("SECTION ITEM ")):
			itemName=line[line.index("SECTION ITEM ")+len("SECTION ITEM "):]
			lineindex +=1
			continue
		if ( line.startswith("SECTION DEFAULT ")):
			defaultName=line[line.index("SECTION DEFAULT ")+len("SECTION DEFAULT "):]
			lineindex +=1
			continue
		if ( line.startswith("SECTION BONUS ")):
			bonusName=line[line.index("SECTION BONUS ")+len("SECTION "):]
			lineindex +=1
			continue
		if ( line.startswith("SECTION")):
			while ( lineindex < len(linebuffer)):
				line = linebuffer[lineindex].strip()
				if ( line.startswith("}")):
					break
				else:
					lineindex +=1
		if ( line.startswith("{")):
			lineindex +=1
			continue

		if ( line.startswith("}")):
			if ( priv != 0 ):
				rule="C;ATTR;PRIV;=calculatePrivs(value) & privs"
				rules.append(rule)
			if ( defaultName != None ):
				glob.noxDefaultRules[defaultName.upper()]=rules
			elif ( itemName != None):
				if ( glob.symbolTable.has_key(itemName)):
					scriptidRule="I;;SCRIPTID;"+glob.symbolTable[itemName]
					rules.append(scriptidRule)
				glob.noxItemRules[itemName.upper()]=rules
			elif ( bonusName != None):
				glob.noxBonusRules[bonusName.upper()]=rules
			defaultName=None
			itemName=None
			bonusName = None
			rules=[]
			lineindex +=1
			continue
		lineContent = line.split()
		attribute=lineContent[0]
		if ( attribute == "#copy"):
			if ( lineContent[1] == "ITEM" ):
				copyDef=lineContent[2]
				rules.extend(glob.noxItemRules[copyDef.upper()])
			elif ( lineContent[1] == "DEFAULT" ):
				copyDef=lineContent[2]
				rules.extend(glob.noxDefaultRules[copyDef.upper()])
			elif ( lineContent[1] == "BONUS" ):
				copyDef=line[line.index("#copy ")+len("#copy "):]
				rules.extend(glob.noxBonusRules[copyDef.upper()])
		else:
			if ( attribute == "PILE"):
				attribute="PILEABLE"
			if ( attribute == "DECAY"):
				priv+=1
				lineindex+=1
				continue
			if ( attribute == "OPENFX"):
				lineindex+=1
				continue
			if ( attribute == "CLOSEFX"):
				lineindex+=1
				continue
			if ( attribute == "DECAY"):
				priv+=1
				lineindex+=1
				continue
			if ( attribute == "RESISTS"):
				lineindex+=1
				continue
			if ( attribute == "NODECAY"):
				if ( priv==1 or priv == 3 ):
					priv=0
				lineindex+=1
				continue
			if ( attribute == "NEWBIE"):
				priv+=2
				lineindex+=1
				continue
			if ( attribute == "STR"):
				attribute="ST"
			if ( attribute == "DEX"):
				attribute="DX"
			if ( attribute == "INT"):
				attribute="IN"

			if ( attribute == "STRADD"):
				attribute="ST2"
			if ( attribute == "DEXADD"):
				attribute="DX2"
			if ( attribute == "INTADD"):
				attribute="IN2"
			if ( attribute == "HITPOINTS"):
				attribute="HP"
			if ( attribute == "DYE"):
				attribute="DYEABLE"
			if ( attribute == "SKILL"):
				lineindex+=1
				continue
			# Name wird als take regel gemappt
			if ( attribute == "NAME"):
				attrVal=""
				if ( len(lineContent) > 1 ):
					for value in lineContent[1:]:
						attrVal += value + " "
					attrVal=attrVal.strip()
				rule="T;NAME;" + attribute + ";" + attrVal
				rules.append(rule)
				lineindex+=1
				continue
			if ( len(lineContent) > 1 ):
				attrVal=""
				for value in lineContent[1:]:
					attrVal += value + " "
				attrVal=attrVal.strip()
				result = regExPureDecimalNumber.search(attrVal)
				if ( not result or attribute == "ID" ) :
					result = regExHexNumber.search(attrVal)
					if ( result) :
						attrVal=decimal("0" + attrVal)
					if ( attribute == "ID" ) :
						rule="T;DISPID;ID;=self.calculateID(" + attrVal + ")"
						rules.append(rule)
						lineindex+=1
						continue
				rule="I;;" + attribute + ";" + attrVal
			else:
				rule="I;;" + attribute + ";"
			rules.append(rule)
		lineindex+=1
	# Privs adden
	if ( priv != 0 ):
		rule="C;ATTR;PRIV;=calculatePrivs(value) & privs"
		rules.append(rule)

	# Letzte Regel bei End of file zuweisen
	if ( defaultName != None ):
		glob.noxDefaultRules[defaultName.upper()]=rules
	elif ( itemName != None):
		glob.noxItemRules[itemName.upper()]=rules
	elif ( bonusName != None):
		glob.noxBonusRules[bonusName.upper()]=rules
	itemFile.close()

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
					includeFile=line[9:].strip()

					includeFile=noxScriptsDir + "/../"+includeFile
					workList.append(includeFile)
				lineindex +=1
	dirContent=["./"]

	while ( len(dirContent) > 0 ):
		curDir = dirContent[0]
		del dirContent[0]
		dirList=os.listdir(noxItemDir + curDir)
		for dirElem in dirList:
			if ( dirElem.endswith(".xss")):
				workList.append(noxItemDir + curDir + "/" + dirElem)
			if os.path.isdir(noxItemDir + curDir + "/" + dirElem):
				dirContent.append(curDir + "/" + dirElem)

	ruleCounter=0
	glob.noxItemRules={}
	glob.noxDefaultRules={}
	glob.noxBonusRules={}
	for file in workList:
		readNoxFile(file)
	return

def readSphereAccounts(sphereCharfile, takeChars):
	if ( not os.path.isfile(sphereCharfile)):
		print "Datei ", sphereCharfile, "wurde nicht gefunden!"
		sys.exit(0)
	accFile = open (sphereCharfile,"r")
	glob.itemTempFile=open("items_pickle.cnv", "w")
	accountCounter=0
	glob.lineCounter=0
	glob.linebuffer=accFile.readlines()
	try:
		while ( glob.lineCounter < len(glob.linebuffer) ):
			line=glob.linebuffer[glob.lineCounter].strip()
			if ( line==None or len(line) == 0 ):
				glob.lineCounter+=1
				continue
			if ( line.strip().startswith("[WORLDCHAR") ):
				charid=line[line.index("[")+ len("WORLDCHAR ")+1:line.index("]")]
				glob.lineCounter+=1
				firstline=glob.lineCounter
				# Ende des Chars suchen
				char_serial=glob.serials
				while ( glob.lineCounter < len(glob.linebuffer) ):
					line=glob.linebuffer[glob.lineCounter].strip()
					if ( line==None or len(line) == 0 ):
						glob.lineCounter+=1
						continue
					if ( line.strip().startswith("[") ):
						#print "Creating Player", charid
						newPlayer = player_character(charid, glob.linebuffer[firstline:glob.lineCounter-1])
						break
					glob.lineCounter+=1
				if ( takeChars == 1 or charid.upper()=="C_HOUSE_VENDOR_M" or charid.upper()=="C_HOUSE_VENDOR_F" ):
					newPlayer.saveChar(glob.charfile)
					glob.accSerialIndex[newPlayer.attributes["SERIAL"]]=newPlayer
					# print "Indexing player ", newPlayer.getAttr("NAME"), "with", newPlayer.getAttr("SERIAL"), "and Position", newPlayer.getAttr("X"), newPlayer.getAttr("Y")
					glob.serialIndex[newPlayer.attributes["SERIAL"]]=glob.serials
					glob.serialCounter+=1
					glob.serials=repr(glob.serialCounter)
					glob.charCounter+=1
				else:
					glob.ignoreCharCont[newPlayer.getAttr("SERIAL")]=1
					del newPlayer
				if ( glob.charCounter % 1000 == 0):
					print "!",
				continue
			if ( line.strip().startswith("[WORLDITEM") ):
				itemid=line[line.index("[")+ len("WORLDITEM ")+1:line.index("]")]
				glob.lineCounter+=1
				firstline=glob.lineCounter
				# Ende des Chars suchen
				while ( glob.lineCounter < len(glob.linebuffer) ):
					line=glob.linebuffer[glob.lineCounter].strip()
					if ( line==None or len(line) == 0 ):
						glob.lineCounter+=1
						continue
					if ( line.strip().startswith("[") ):
						if ( not glob.itemIdIndex.has_key(itemid.upper()) ): glob.itemIdIndex[itemid.upper()]=1
						newItem = worldItem(itemid, glob.linebuffer[firstline:glob.lineCounter-1])
						newItem.setSerial(glob.itemSerials)

						glob.itemSerialCounter+=1
						glob.itemSerials=repr(glob.itemSerialCounter)
						if ( itemid.startswith("i_mt")):
							newPlayer = player_character(newItem.getAttr("MORE1"), glob.linebuffer[firstline:glob.lineCounter-1])
							newPlayer.saveChar(glob.charfile)
							# print "Indexing mount to owner", newPlayer.getAttr("LINK"), "with", newPlayer.getAttr("SERIAL"), "and Position", glob.accSerialIndex[newPlayer.getAttr("LINK")].getAttr("X"), glob.accSerialIndex[newPlayer.getAttr("LINK")].getAttr("Y")
							glob.accSerialIndex[newPlayer.attributes["SERIAL"]]=newPlayer
							glob.serialIndex[newPlayer.attributes["SERIAL"]]=glob.serials
							glob.serialCounter+=1
							glob.serials=repr(glob.serialCounter)
							glob.charCounter+=1
						break
					glob.lineCounter+=1
				cPickle.dump(newItem, glob.itemTempFile)
				del newItem
				newItem=None
				if ( glob.itemSerialCounter % 10000 == 0):
					print ".",
				continue
			glob.lineCounter+=1
	except:
		print "Exception in line", glob.lineCounter, ":", line
		traceback.print_exc(sys.stdout)
		sys.exit(1)
	glob.linebuffer=None
	glob.itemTempFile.close()

def saveItems():
	itemTempFile=open("items_pickle.cnv", "r")
	if ( os.path.exists("items_pickle.cnv")):
		if ( os.path.getsize("items_pickle.cnv") > 0 ):
			item=cPickle.load(itemTempFile)
			while ( item != None):
				if (not glob.missing.has_key( item.itemid)):
					item.save(glob.itemfile)
					glob.itemCounter+=1
					if ( glob.itemCounter %1000 == 0): print ".",
				else:
					glob.missing[item.itemid]+=1
				del item
				item=None
				try:
					item=cPickle.load(itemTempFile)
				except:
					break
			itemTempFile.close()


def saveRetries():
	retries=glob.retryItems
	index=0;
	for item in retries:
		if (not glob.missing.has_key( item.itemid)):
			item.save(glob.itemfile)
			glob.itemCounter+=1
			if ( glob.itemCounter %1000 == 0): print ".",
		else:
			glob.missing[item.itemid]+=1
		glob.retryItems[index]=None
		del item
		item=None
		index+=1;
	print "Finished retries"

# load playerchar.rule für mapping tabellen
def loadCharMappings():

	path=os.path.dirname(sys.argv[0])
	ruleFile = open(path + "/chars_mapping.rule", "r")
	linebuffer = ruleFile.readlines()
	ruleCounter=0
	lineindex=0
	glob.ruleIndex={}
	currentRule=""
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		if ( line == None or line == ""):
			lineindex +=1
			continue
		if ( line.startswith("#")):
			lineindex +=1
			continue
		charMap=line.split(";")
		# print charMap
		# sphere char name assigned to nox char number
		glob.charMappingTable[charMap[0]]=decimal(charMap[2])
		lineindex+=1


# load playerchar.rule für mapping tabellen
def loadRules():

	path=os.path.dirname(sys.argv[0])
	ruleFile = open(path + "/player_chars.rule", "r")
	linebuffer = ruleFile.readlines()
	ruleCounter=0
	lineindex=0
	rules=[]
	glob.ruleIndex={}
	currentRule=""
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		if ( line == None or line == ""):
			lineindex +=1
			continue
		if ( line.startswith("#")):
			lineindex +=1
			continue
		if ( line.startswith("[")):
			if ( glob.translationRules.has_key(currentRule.upper()) ):
				print "Rulefile", "/player_chars.rule", ": Warning: Rule", currentRule, "already defined elsewhere, overwriting previous definition"
			if ( currentRule != ""):
				glob.translationRules[currentRule.upper()]=rules
			currentRule = line[line.index("[")+1:line.index("]")]
			rules=[]
			lineindex +=1
			continue
		if ( currentRule != ""):
			rules.append(line)
		lineindex+=1
	# Letzte Regel bei End of file zuweisen
	if ( currentRule != ""):
		glob.translationRules[currentRule.upper()]=rules

	path=os.path.dirname(sys.argv[0])
	dirList=os.listdir(path)
	workList=[]
	for dirElem in dirList:
		if ( dirElem.startswith("items_")):
			workList.append(dirElem)

	ruleCounter=0
	for file in workList:
		ruleFile = open(path + "/" + file, "r")
		linebuffer = ruleFile.readlines()
		lineindex=0
		glob.ruleIndex={}
		currentRule=""
		while ( lineindex < len(linebuffer)):
			line = linebuffer[lineindex].strip()
			if ( line == None or line == ""):
				lineindex +=1
				continue
			if ( line.startswith("#")):
				lineindex +=1
				continue
			if ( line.startswith("[")):
				if ( glob.translationRules.has_key(currentRule.upper()) ):
					print "Rulefile", file, ": Warning: Rule", currentRule, "already defined elsewhere, overwriting previous definition"
				if ( len(rules) == 0 and currentRule != ""):
					glob.discard[currentRule.upper()]=1
				if ( currentRule != ""):
					glob.translationRules[currentRule.upper()]=rules
				currentRule = line[line.index("[")+1:line.index("]")]
				rules=[]
				lineindex +=1
				continue
			if ( currentRule != ""):
				#rule=line.split(";")
				rules.append(line)
			lineindex+=1
	# Letzte Regel bei End of file zuweisen
		if ( currentRule != ""):
			glob.translationRules[currentRule.upper()]=rules

	return

def cleanRules():
	rules=[]
	indiv_rules=[]
	try:
		for itemid in glob.itemIdIndex:
			rules=[]
			currentRuleIndex={}
			indiv_rules=[]
			if ( glob.itemIdIndex[itemid] == 1 ):
				glob.itemIdIndex[itemid] = 2
				for rule in glob.translationRules["DEFAULT"]:
					rules.append(rule)
				if ( glob.translationRules.has_key(itemid.upper()) ):
					for rule in glob.translationRules[itemid.upper()]:
						indiv_rules.append(rule)

					# Deleting all default rules that are also defined indiv
					indexCount=0
					delRules=[]
					for rule in rules:

						indexCount+=1
						if ( rule == None):
							continue
						ruleParts=rule.split(";")
						if ( ruleParts[0].startswith("MAPPING")):
							continue
						sphereName=ruleParts[1]
						noxName=ruleParts[2]
						currentRuleIndex[noxName.upper()]=1
						for indiv_rule in indiv_rules:
							ruleParts=indiv_rule.split(";")
							if ( ruleParts[0].startswith("MAPPING")):
								continue
							currentRuleIndex[ruleParts[2].upper()]=1
							if ( noxName == ruleParts[2]):
								delRules.append(indexCount-1)
								break
							if ( sphereName == ruleParts[1] ):
								delRules.append(indexCount-1)
								break
					delRules.reverse()
					for delIndex in delRules:
						del rules[delIndex]
					# Searching for mappings
					indexCount=0
					delRules=[]
					for indiv_rule in indiv_rules:

						indexCount+=1
						if ( indiv_rule == None):
							continue
						ruleParts=indiv_rule.split()
						if ( ruleParts[0].startswith("MAPPING")):
							# Append a rule to insert a script id
							if ( glob.symbolTable.has_key(ruleParts[1])):
								indiv_rules.append('I;;SCRIPTID;' + str(glob.symbolTable[ruleParts[1]]))
							if ( glob.noxItemRules.has_key(ruleParts[1].upper())):
								for rule in glob.noxItemRules[ruleParts[1].upper()]:
									# rule target is the name of the nox attribute
									ruleContent=rule.split(";")
									ruletarget=ruleContent[2]
									if ( currentRuleIndex.has_key(ruletarget.upper()) ):
										# Attribute has been defined already in another rule
										continue
									else:
										currentRuleIndex[ruletarget.upper()]=1
										indiv_rules.append(rule)
							else:
								glob.noxMissing[ruleParts[1]]=1
							delRules.append(indexCount-1)
					delRules.reverse()
					for delIndex in delRules:
						del indiv_rules[delIndex]

					rules+=indiv_rules
				else:
					#print "Error: Don't know how to convert entry", itemid
					# print "Error: Missing entry in rule table:", itemid

					continue
				newRules=[]
				for rule in rules:
					ruleParts=rule.split(";")
					if ( len(ruleParts) > 3):
						if ( ruleParts[3].startswith("=")):
							# Precompile rule
							if ( not glob.compiledRules.has_key(ruleParts[3][1:])):
								glob.compiledRules[ruleParts[3][1:]]=compiler.compile(ruleParts[3][1:],"rule_compiler.err", 'eval')
						elif ( ruleParts[3].startswith("$")):
							if ( glob.symbolTable.has_key(ruleParts[3])):
								ruleParts[3]=glob.symbolTable[ruleParts[3]]
					if ( rule != None):
						newRules.append(ruleParts)
				glob.translationRules[itemid.upper()]=newRules
	except:
		print "Exception in Rule", rule, "for item ", itemid
		raise

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
	print "account_converter -s <Full Path + Spherechars.scp > -t <Nox Wizard nxwchars.wsc file (full path)> -d Nox Wizard Account.adm file (full path)"
	print "-s <Sphere Directory> :	contains the source path and filename of the spherechars.scp, mandatory"
	print "-t <Target Directory> : 	the path (without filename) of the nox wizard nxwchars.wsc file"
	print "-d <Account File> : 	the path and filename of the nox wizard account.adm file"
	print "-i <Target Directory> : 	the path (without filename) of the nox wizard scripts directory"

def main():
# Initializing variables

	glob.accNameTable={}
	glob.translationRules={}
	targetfile=""
	sourcedir=""
	noxItemDir=None
	glob.lineCount=0
	glob.serialIndex={}
	glob.generate=false
	glob.itemArray=[]
	glob.lineCounter=0
	glob.charCounter=1
	glob.itemCounter=0
	glob.serialCounter=1
	glob.itemSerialCounter=1073741825
	glob.itemSerials=str(glob.itemSerialCounter)
	glob.serials=str(glob.serialCounter)
	glob.accSerialIndex={}
	glob.itemIdIndex={}
	glob.itemCounter=0
	glob.backpackIndex={}
	glob.bankboxIndex={}
	glob.charMappingTable={}
	glob.houseOwner={}
	glob.symbolTable={}
	glob.noxMissing={}
	glob.compiledRules={}
	glob.retryItems=[]
	glob.discard={}
	glob.ignoreCharCont={}
	glob.discardedItems=0
	glob.booknumber=1
	print "Sphere 55i to Nox Wizard 0.82 worldsave converter"
	print "This program was conceived and written by Wintermute"
# argument test
	if ( len(sys.argv) < 2 ):
		usage()
		sys.exit()
	if ( sys.argv[1] == None or sys.argv[1]=="" ):
		usage()
		sys.exit();
# argument eval
	opts, args = getopt.getopt(sys.argv[1:], "d:hi:s:t:", ["accdir", "help", "itemdir", "sourcedir=", "target="])
	for opt, arg in opts:
		if opt == "-h":
			usage()
			sys.exit()
		if opt == "-t":
			nox_save_dir=arg
			if ( not os.path.isdir(nox_save_dir)):
				print "Nox Save Dir  directory does not exist or is not a directory!"
				sys.exit()
		if opt == "-d":
			nox_acc_file=arg
			if ( not os.path.isfile(nox_acc_file)):
				print "Nox File accounts.adm does not exist or is not a valid file!"
				sys.exit()
		if opt == "-s":
			sphere_char_file=arg
			if ( not os.path.isfile(sphere_char_file)):
				print "Spherechars.scp does not exist or is not a valid file!"
				sys.exit()
		if opt == "-g":
			glob.generate=true;
		if opt == "-i":
			noxScriptsDir=arg
			if ( not os.path.isdir(noxScriptsDir)):
				print "Nox Scripts Directory does not exist or is not a directory!"
				sys.exit()
	if ( sphere_char_file == None):
		print "Spherechars.scp not given"
		usage()
		sys.exit()
	if ( nox_acc_file == None):
		print "accounts.adm not given"
		usage()
		sys.exit()
	if ( targetfile == None):
		print "No target directory given"
		usage()
		sys.exit()
	if ( noxScriptsDir == None):
		print "No Nox scripts dir given"
		usage()
		sys.exit()
# Initializing file buffers
	glob.errorfile=open (os.path.dirname(sys.argv[0]) + "/" + "errors.log", "w")
	targetfile=nox_save_dir + "/nxwchars.wsc"
	if ( 	os.path.isfile(targetfile+".old")):
		os.remove(targetfile+".old")
	if ( os.path.isfile(targetfile)):
		os.rename(targetfile, targetfile + ".old")
	glob.missing={}
	glob.charfile=open (targetfile, "w")
	targetdir=os.path.dirname(targetfile)
	itemfileName=targetdir + "/nxwitems.wsc"
	glob.itemfile=open (itemfileName, "w")
	bookfileName=targetdir + "/nxwbook.wsc"
	glob.bookfile=open (bookfileName, "w")

# Initializign account index
	print "Initializing..."
	if ( os.path.isfile("items_pickle.cnv")):
		os.remove("items_pickle.cnv")
	print "Reading nox wizard account file...",
	readNoxAccounts(nox_acc_file)
	print "Done"
# Initializing Itemvalues
	print "Reading nox wizard items files...",
	readNoxItems(noxScriptsDir )
	print "Done"
	print "Reading nox wizard symbol files...",
	loadSymbols(noxScriptsDir)
	print "Done"
# Loading player rule file
	print "Loading converter rules...",
	loadRules()
	print "Done"
# Loading charmappings
	print "Loading char mapping file for spawn creation...",
	loadCharMappings()
	print "Done"
# reading and converting chars
	print "Reading spherechars.scp...",
	readSphereAccounts(sphere_char_file, 1)
	print "Done"
	print "Cleaning rules",
	cleanRules()
	print "Done"
	print "Converting and saving items from spherechars.scp...",
	saveItems()
	print "Done"
	glob.itemTempFile.close()
	print "Reading sphereworld.scp...",
	readSphereAccounts(os.path.dirname(sphere_char_file) + "/" + "sphereworld.scp", 0)
	print "Done"
	print "Compiling rules for new items...",
	cleanRules()
	print "Done"
	print "Converting and saving items from sphereworld.scp...",
	glob.itemArray=[]
	saveItems()
	print "Done"
	print "Reconverting items with indexing errors during conversion..."
	cleanRules()
	saveRetries()
	print "Done"
	print "Closing files...",
	glob.itemfile.write("\n")
	glob.itemfile.write("EOF\n")

	glob.charfile.write("\n")
	glob.charfile.write("EOF\n")
	glob.charfile.close()
	glob.itemfile.close()
	glob.errorfile.close()
	print "Done"
	print "Removing temporary files...",
	glob.itemTempFile.close()
	os.remove("items_pickle.cnv");
	print "Done"
	print "Writing missing converter rules to missing.txt...",

	missingFile=open (os.path.dirname(sys.argv[0]) + "/" + "missing.txt", "w")
	for entry in glob.missing.keys():
		missingFile.write("Don't know how to convert entry " + entry + ", totalling " + str (glob.missing[entry]) + " entries\n")
	missingFile.close()
	missingFile=open (os.path.dirname(sys.argv[0]) + "/" + "NoxMissing.txt", "w")
	for entry in glob.noxMissing.keys():
		missingFile.write("Don't know entry " + entry + ", totalling " + str (glob.noxMissing[entry]) + " entries in Nox!\n")
	missingFile.close()
	print "Done"
	print glob.discardedItems, "items have been discarded during the conversion"
main()