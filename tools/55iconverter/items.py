# -*- coding: utf-8 -*-

import glob,sys, re
from common_functions import *
import traceback
import cPickle

spellMapping=( "i_scroll_reactive_armor","i_scroll_clumsy","i_scroll_create_food","i_scroll_feeblemind"
	,"i_scroll_heal","i_scroll_magic_arrow","i_scroll_night_sight","i_scroll_weaken","i_scroll_agility"
	,"i_scroll_cunning","i_scroll_cure","i_scroll_harm","i_scroll_magic_trap","i_scroll_magic_untrap"
	,"i_scroll_protection","i_scroll_strength","i_scroll_bless","i_scroll_fireball","i_scroll_magic_lock"
	,"i_scroll_poison","i_scroll_telekinesis","i_scroll_teleport","i_scroll_unlock","i_scroll_wall_of_stone"
	,"i_scroll_archcure","i_scroll_archprotection","i_scroll_curse","i_scroll_fire_field","i_scroll_greater_heal"
	,"i_scroll_lightning","i_scroll_mana_drain","i_scroll_recall","i_scroll_blade_spirits","i_scroll_dispel_field"
	,"i_scroll_incognito","i_scroll_magic_reflection","i_scroll_mind_blast","i_scroll_paralyze"
	,"i_scroll_poison_field","i_scroll_summon_creature","i_scroll_dispel","i_scroll_energy_bolt","i_scroll_explosion"
	,"i_scroll_invisibility","i_scroll_mark","i_scroll_mass_curse","i_scroll_paralyze_field","i_scroll_reveal"
	,"i_scroll_chain_lightning","i_scroll_energy_field","i_scroll_flamestrike","i_scroll_gate_travel"
	,"i_scroll_mana_vampire","i_scroll_mass_dispel","i_scroll_meteor_swarm","i_scroll_polymorph"
	,"i_scroll_earthquake","i_scroll_energy_vortex","i_scroll_resurrection","i_scroll_summon_elem_air"
	,"i_scroll_summon_daemon","i_scroll_summon_elem_earth","i_scroll_summon_elem_fire","i_scroll_summon_elem_water"
	)
def generateSpellbookContent(spellbookId, bitmask, part=0):

	for i in range(32):
		index=2**i
		if ( (bitmask&index) == index ):
			#print "i:", i, "index", part*32+i-1
			spellDef=spellMapping[part*32+i-1]
			try:
				linebuffer=[]
				linebuffer.append("[" + spellDef + "]" + "\n")
				linebuffer.append("SERIAL=1" + "\n")
				linebuffer.append("ATTR=04" + "\n")
				try:
					linebuffer.append("CONT=" + spellbookId.getAttr("SERIAL"))
				except:
					linebuffer.append("CONT=" + spellbookId)
				linebuffer.append("\n")
				newItem = worldItem(spellDef, linebuffer)
				newItem.setSerial(glob.itemSerials)
				#cPickle.dump(newItem, glob.itemTempFile)
				glob.retryItems.append(newItem)
				glob.itemSerialCounter+=1
				glob.itemSerials=repr(glob.itemSerialCounter)
			except:
				traceback.print_exc(file=sys.stdout)
	return "0"
def copyRunes(runebook):
	for i in range(16):
		try:
			if ( runebook.hasAttr("TAG.RUNE"+str(i+1)+"POS")):
				linebuffer=[]
				linebuffer.append("[i_rune_marker]"+"\n")
				linebuffer.append("SERIAL=1" + "\n")
				linebuffer.append("NAME="+runebook.getAttr("TAG.RUNE"+str(i+1)+"NAME")+"\n")
				try:
					linebuffer.append("CONT=" + runebook.getAttr("SERIAL")+"\n")
				except:
					linebuffer.append("CONT=" + runebook+"\n")
				position=runebook.getAttr("TAG.RUNE"+str(i+1)+"POS")
				linebuffer.append("MOREP="+position+"\n")
				linebuffer.append("P="+str(i)+",0,0\n")
				linebuffer.append("\n")
				newItem = worldItem("i_rune_marker", linebuffer)
				newItem.setSerial(glob.itemSerials)
				glob.retryItems.append(newItem)
				glob.itemSerialCounter+=1
				glob.itemSerials=repr(glob.itemSerialCounter)
				glob.retryItems.append(newItem)
		except:
			traceback.print_exc(file=sys.stdout)
	return "0"

def generateBook(book):
	try:
		glob.bookfile.write("SECTION RWBOOK " + str(glob.booknumber)+"\n")
		glob.bookfile.write("{"+"\n")
		glob.bookfile.write("AUTHOR ");
		if ( book.hasAttr("AUTHOR")): glob.bookfile.write(book.getAttr("AUTHOR"))
		glob.bookfile.write("\n")
		glob.bookfile.write("TITLE ");
		if ( book.hasAttr("NAME")): glob.bookfile.write(book.getAttr("NAME"))
		glob.bookfile.write("\n")
		# making the book lines first so we can see how many pages there are
		bookcontent=[]
		pages=0
		for i in range(63):
			if ( i % 8 == 0 ):
				bookcontent.append("PAGE " + str(i/8) + "\n")
				pages+=1
			if ( book.hasAttr("BODY."+str(i))):
				bookcontent.append("LINE " + str(i%8) + " " + book.getAttr("BODY."+ str(i)) + "\n")
		glob.bookfile.write("NUMPAGES "+ str(pages))
		glob.bookfile.write("\n")
		glob.bookfile.writelines(bookcontent)
		glob.bookfile.write("}"+"\n"+"\n")
		booknumber=	glob.booknumber
		glob.booknumber+=1
	except:
		traceback.print_exc(file=sys.stdout)
	return str(booknumber)

def generateHouseKey(ownerid, houseid):
	try:
		linebuffer=[]
		linebuffer.append("[i_nox_housekey]" + "\n")
		linebuffer.append("SERIAL=1" + "\n")
		linebuffer.append("NAME=a house key" + "\n")
		linebuffer.append("ATTR=04" + "\n")
		linebuffer.append("P=50,50" + "\n")
		linebuffer.append("MORE=" + houseid + "\n")
		linebuffer.append("CONT=" + ownerid + "\n")
		linebuffer.append("\n")
		newItem = worldItem("i_nox_housekey", linebuffer)
		newItem.setSerial(glob.itemSerials)
		#cPickle.dump(newItem, glob.itemTempFile)
		glob.retryItems.append(newItem)
		glob.itemSerialCounter+=1
		glob.itemSerials=repr(glob.itemSerialCounter)
		if ( not glob.itemIdIndex.has_key("I_NOX_HOUSEKEY")):
			glob.itemIdIndex["I_NOX_HOUSEKEY"] = 1
	except:
		traceback.print_exc(file=sys.stdout)
	return newItem.getSerial()

def generateTillerman(shipid, x,y,z):
	linebuffer=[""]*5
	linebuffer[0]="[i_ship_tillerman]" + "\n"
	linebuffer[1]+="NAME a tillerman" + "\n"
	linebuffer[2]+="P " + x + ","+ y + ","+ z + "\n"
	linebuffer[3]+="MORE " + shipid + "\n"

regExHexNumber=re.compile("^[0-9|A-F]+$", re.IGNORECASE)
regExPureDecimalNumber=re.compile("^[1-9][0-9]*$", re.IGNORECASE)

glob.lastid=""
class worldItem:

	def __init__ (self, itemid, chardefinition):
		# itemid ist die id des sphere char also c_man oder c_woman
		# chardef enthält den Abschnitt aus der spherechars.scp
		self.itemid=itemid
		self.attributes={}
		self.readDef(chardefinition)
		self.serial=""

	def useIfNotNULL(self, value, targetValue):
		if ( value != None or value != "" ):
			return targetValue
		else:
			raise valueNullException()

	def calculateID(self, value):
		if (self.hasAttr("DISPID") ):
			result = regExHexNumber.search(self.getAttr("DISPID"))
			if ( result and not self.getAttr("DISPID").startswith("i_")):
				return decimal(self.getAttr("DISPID"))
			elif self.getAttr("DISPID").upper().startswith("I_"):
				if ( glob.translationRules.has_key(self.getAttr("DISPID").upper())):
					if ( not glob.itemIdIndex.has_key(self.getAttr("DISPID").upper())):
						glob.itemIdIndex[self.getAttr("DISPID").upper()]=1
						raise KeyError
					for rule in glob.translationRules[self.getAttr("DISPID").upper()]:
						if ( rule[2]=="ID"):
							if ( not rule[3].startswith("=")):
								return decimal(rule[3])
							else:
								value=str(value)
								self.attributes["DISPID"]=""
								self.attributes["ID"]=""
								eval_expression=rule[3][1:]
								#print "Using rule ", eval_expression
								return decimal(eval(eval_expression))
		elif (self.hasAttr("ID") ):
			result = regExHexNumber.search(self.getAttr("ID"))
			if ( result and not self.getAttr("ID").upper().startswith("I_") ):
				return decimal(self.getAttr("ID"))
			else:
				return decimal(self.getAttr("ID"))
		elif (str(value).upper().startswith("I_")):
			if ( glob.translationRules.has_key(str(value).upper())):
				if ( not glob.itemIdIndex.has_key(self.getAttr("DISPID").upper())):
					glob.itemIdIndex[self.getAttr("DISPID").upper()]=1
					raise KeyError
				for rule in glob.translationRules[str(value).upper()]:
					if ( rule[2]=="ID"):
						if ( not rule[3].startswith("=")):
							return decimal(rule[3])
						else:
							value=str(value)
							self.attributes["DISPID"]=""
							self.attributes["ID"]=""
							eval_expression=rule[3][1:]
							return decimal(eval(eval_expression))

		else:
			return str(value)
		return str(value)

	def readDef(self, lines):
		lineindex = 0
		while (lineindex < len(lines)):
			try:
				line=lines[lineindex].strip()
				if ( line == None or line == "" ):
					lineindex +=1
					continue
				if ( line.find("=") > 0 ):
					# Extra conversion of P values
					keyword=line[0:line.index("=")]
					value=line[line.index("=")+1:]
					if ( keyword == "SERIAL"):
						glob.serialIndex[value]=glob.itemSerials
					if ( keyword == "P" ):
						koors = value.split(",")
						self.attributes["X"]=koors[0]
						self.attributes["Y"]=koors[1]
						if ( len(koors) > 2):
							self.attributes["Z"]=koors[2]
					elif ( keyword == "MOREP" ):
						koors = value.split(",")
						self.attributes["MOREX"]=koors[0]
						self.attributes["MOREY"]=koors[1]
						if ( len(koors) > 2):
							self.attributes["MOREZ"]=koors[2]
					else:
						# print "Setting ", keyword, "to", value, "for", self.itemid
						self.attributes[keyword]=value
				else:
					keyword=line
					self.attributes[keyword]=""
			except:
				print "Unknown Attribute", line
				sys.exit(0)
			lineindex+=1
		if ( self.itemid.startswith("i_multi")):
			if ( self.attributes.has_key("MORE1") and self.attributes.has_key("SERIAL")):
				getHouseOwner(self.attributes["MORE1"], self.attributes["SERIAL"])
		if ( self.itemid == "i_bankbox" ):
			if ( glob.serialIndex.has_key(self.attributes["CONT"])):
				glob.bankboxIndex[glob.serialIndex[self.attributes["CONT"]]]=glob.itemSerials
	def setSerial(self, serial):
		self.serial=serial
	def getSerial(self):
		return self.serial

	def save(self, itemfile):

		rules=[]
		haveid=0
		if ( glob.discard.has_key(self.itemid.upper()) ):
			glob.discardedItems+=1
			return
		if ( glob.translationRules.has_key(self.itemid.upper()) and not glob.missing.has_key(self.itemid) ):
			for rule in glob.translationRules[self.itemid.upper()]:
				if ( self.hasAttr("DISPID") and rule[2]=="ID" and rule[0] != "I" and rule[0] != "C" ):
					if ( glob.translationRules.has_key(self.getAttr("DISPID").upper()) and not glob.missing.has_key(self.getAttr("DISPID").upper()) ):
						for newrule in glob.translationRules[self.itemid.upper()]:
							if ( newrule[2]=="ID" ):
								rules.append(newrule)
					else:
						rules.append(rule)
				else:
					rules.append(rule)
		else:
			#print "Error: Don't know how to convert entry", self.itemid
			#print "Error: Missing entry in rule table:", self.itemid
			if ( glob.missing.has_key(self.itemid)):
				glob.missing[self.itemid]+=1
			else:
				glob.missing[self.itemid]=1
			return
		ruleFields=[]
		lines=[]
		lines.append("SECTION WORLDITEM " + repr(glob.itemCounter) + "\n")
		lines.append("{" + "\n")
		#if ( self.itemid.upper().startswith("i_book".upper())): print "Debug: Rules", self.itemid, rules
		for ruleFields in rules:
			#if ( self.itemid.upper().startswith("i_book".upper()) ): print "Debug: Lines", self.itemid, lines, ruleFields

			try:
				if ( ruleFields[0] != "D" and ruleFields[2] == "ID" ):
					haveid=1
				if ( ruleFields[0] == "I" ):

					# Field 2 is the keyword to write
					# Field 3 is the value to write
					# print "Line:", ruleFields
					if ( ruleFields[3].startswith("=") ):
						eval_expression=ruleFields[3][1:]
						value=""
						# Replace expression with precompiled bytecode
						if ( glob.compiledRules.has_key(eval_expression)):
							eval_expression=glob.compiledRules[eval_expression]
						lines.append(ruleFields[2] + " " + eval(eval_expression) + "\n")
					else:
						value=ruleFields[3]
						lines.append(ruleFields[2] + " " + value  + "\n")
				elif ( ruleFields[0] == "C" ):

					# Field 1 is the sphere keyword to look for
					# Field 2 is the keyword to write
					# Field 3 is the value to write
					if ( ruleFields[3].startswith("=") ):
						# Evaluate the python expression in the string
						if ( ruleFields[3].upper() == "=VALUE"):
							if ( self.attributes.has_key(ruleFields[1])):
								lines.append(ruleFields[2] + " " + self.attributes[ruleFields[1]] + "\n")
							#else:
								#if ( self.itemid == "i_nox_housekey"): print "Warning: Missing attribute for conversion rule", ruleFields, "ignoring rule..."
						else:
							eval_expression=ruleFields[3][1:]
							value=""
							if ( self.attributes.has_key(ruleFields[1])):
								value=self.attributes[ruleFields[1]]
							else:
								#if ( self.itemid == "i_nox_housekey"):print "Warning: Missing attribute for conversion rule", ruleFields, "ignoring rule..."
								continue
						# Replace expression with precompiled bytecode
							if ( glob.compiledRules.has_key(eval_expression)):
								eval_expression=glob.compiledRules[eval_expression]
							lines.append(ruleFields[2] + " " + eval(eval_expression) + "\n")
							continue
					else:
						lines.append(ruleFields[2] + " " + ruleFields[3]  + "\n")
						continue
				elif ( ruleFields[0] == "T" ):
					if ( ruleFields[3].startswith("=") ):
						# Evaluate the python expression in the string
						#if ( ruleFields[3].upper() == "=VALUE"):
						#	if ( self.attributes.has_key(ruleFields[1])):
						#		lines.append(ruleFields[2] + " " + self.attributes[ruleFields[1]] + "\n")
						#else:
							eval_expression=ruleFields[3][1:]
							value=""
							if ( self.attributes.has_key(ruleFields[1])):
								value=self.attributes[ruleFields[1]]
							if ( glob.compiledRules.has_key(eval_expression)):
								eval_expression=glob.compiledRules[eval_expression]
							lines.append(ruleFields[2] + " " + eval(eval_expression) + "\n")
					elif ( self.attributes.has_key(ruleFields[1])):
						lines.append(ruleFields[2] + " " + self.attributes[ruleFields[1]] + "\n")
						continue
					elif (len(ruleFields) > 3 ):
						if ( ruleFields[3] != ""):
							#print "Debug: ", ruleFields
							lines.append(ruleFields[2] + " " + ruleFields[3] + "\n")
							continue
					#else:
					#	print "Warning: Missing attribute for conversion rule", ruleFields, "ignoring rule..."
				elif ( ruleFields[0] == "D" ):
					# Nothing to do, since the value won't be saved
					pass
				#if ( self.itemid.upper().startswith("i_book".upper()) and ruleFields[2] == "MOREZ"): print "Debug: Rules", lines, ruleFields
			except KeyError:
				if ( self.attributes.has_key("CONT") and glob.ignoreCharCont.has_key(self.attributes["CONT"]) ):
					return
				if ( not self in glob.retryItems):
					glob.retryItems.append(self)
					return
				else:
					glob.errorfile.write( "Exception while converting with rule "+ self.itemid + " possibly missing key for index table " + value + " for " + self.getAttr("SERIAL") + " Rules " + repr(ruleFields) + "\n" )
			except NoSuchHouseOwner:
				if ( not self in glob.retryItems):
					glob.retryItems.append(self)
					return
				else:
					continue
			except NoSuchContainerException:
				if ( not self in glob.retryItems):
					glob.retryItems.append(self)
					return
				else:
					glob.errorfile.write( "Exception while converting with rule "+ self.itemid + " possibly missing container/player index table " + value + " Rules " + repr(ruleFields) + "\n" )
					return
			except NoSuchTypeException:
				glob.errorfile.write( "No nox type mapping for type" + value)
			except valueNullException:
				pass
			except ignoreItemException:
				return
			except:
				if ( self.attributes.has_key("CONT") and glob.ignoreCharCont.has_key(self.attributes["CONT"]) ):
					return
				glob.errorfile.write( "Exception while converting with rule " + self.itemid + " possibly rule bug due to " + repr(ruleFields)+ " value is " +  value + "\n")
				#traceback.print_exc(file=sys.stdout)
				return
		del ruleFields
		del rules
		ruleFields=None
		rules=None
		# Dumb way to determine if backpack is players backpack
		if ( self.itemid.upper() == "I_BACKPACK" or self.itemid.upper() == "I_VENDORBOX"):
			if ( self.attributes.has_key("CONT")):
				cont_id_old=self.attributes["CONT"]
				if ( glob.accSerialIndex.has_key(cont_id_old)):
					lines.append("LAYER 21\n")
					glob.backpackIndex[cont_id_old]=self.serial

		lines.append("}" + "\n")
		lines.append("\n")
		if ( haveid == 0 ):
			glob.errorfile.write( "Item converted without having an id " + self.itemid + " at serial " + str(self.serial)+"\n")
			return
		itemfile.writelines(lines)
		itemfile.flush()
		del lines
		#if ( self.itemid == "i_nox_housekey"): print "Result:", lines
		ruleFields=None
		lines=None
		rules=None


	def hasAttr(self, attr):
		return self.attributes.has_key(attr)

	def getAttr(self, attr):
		return self.attributes[attr]