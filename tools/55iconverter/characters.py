# -*- coding: utf-8 -*-

import glob, traceback
from common_functions import *
from items import *

class player_character:

	def __init__ (self, charid, chardefinition):
		# charid ist die id des sphere char also c_man oder c_woman
		# chardef enthält den Abschnitt aus der spherechars.scp
		self.charid=charid
		self.serial=0
		self.attributes={}
		self.readDef(chardefinition)


	def readDef(self, lines):
		lineindex = 0
		while (lineindex < len(lines)):
			line=lines[lineindex].strip()
			if ( line == None or line == "" ):
				lineindex +=1
				continue
			if ( line.index("=") > 0 ):
				# Extra conversion of P values
				keyword=line[0:line.index("=")]
				value=line[line.index("=")+1:]
				if ( keyword == "SERIAL"):
					glob.serialIndex[value]=glob.serials
				if ( keyword == "P" ):
					koors = value.split(",")
					self.attributes["X"]=koors[0]
					self.attributes["Y"]=koors[1]
					if ( len(koors) > 2):
						self.attributes["Z"]=koors[2]
					if ( len(koors) > 3):
						self.attributes["M"]=koors[3]
				else:
					self.attributes[keyword]=value
			lineindex+=1

	def saveChar(self, charfile):

		try:
			ruleFields=[]
			value=""
			if ( glob.translationRules.has_key(self.charid.upper()) ):
				rules=glob.translationRules[self.charid.upper()]
			else:
				#print "Error: Don't know how to convert entry", self.charid
				#print "Error: Missing entry in rule table:", self.charid
				if ( glob.missing.has_key(self.charid)):
					glob.missing[self.charid]+=1
				else:
					glob.missing[self.charid]=1
				return
			charfile.write("SECTION CHARACTER " + repr(glob.charCounter) + "\n")
			charfile.write("{" + "\n")
			#print "Debug: rules are", rules
			#print "Translating", self.charid
			for entry in rules:
				#print "Working on rule", entry
				ruleFields=entry.split(";")
				if ( ruleFields[0].upper() == "I" ):
					# Field 2 is the keyword to write
					# Field 3 is the value to write
					if ( ruleFields[3].startswith("=") ):
						eval_expression=ruleFields[3][1:]
						value=""
												# Replace expression with precompiled bytecode
						if ( glob.compiledRules.has_key(eval_expression)):
							eval_expression=glob.compiledRules[eval_expression]

						charfile.write(ruleFields[2] + " " + eval(eval_expression) + "\n")
					else:
						if ( ruleFields[3].startswith("$")):
							if ( glob.symbolTable.has_key(ruleFields[3])):
								value=glob.symbolTable[ruleFields[3]]
							else:
								value=ruleFields[3]
						else:
							value=ruleFields[3]
						charfile.write(ruleFields[2] + " " + value  + "\n")

				elif ( ruleFields[0].upper() == "C" ):
					# Field 1 is the sphere keyword to look for
					# Field 2 is the keyword to write
					# Field 3 is the value to write
					if ( ruleFields[3].startswith("=") ):
						# Evaluate the python expression in the string
						if ( ruleFields[3].upper() == "=VALUE"):
							if ( self.attributes.has_key(ruleFields[1])):
								charfile.write(ruleFields[2] + " " + self.attributes[ruleFields[1]] + "\n")
							#else:
							#	print "Warning: Missing attribute for conversion rule", ruleFields, "ignoring rule..."
						else:
							eval_expression=ruleFields[3][1:]
							value=""
							if ( self.attributes.has_key(ruleFields[1])):
								value=self.attributes[ruleFields[1]]
							else:
								#print "Warning: Missing attribute for conversion rule", ruleFields, "ignoring rule..."
								continue
							# print "Debug: Doing", eval_expression, "resulting in ", eval(eval_expression)
													# Replace expression with precompiled bytecode
							if ( glob.compiledRules.has_key(eval_expression)):
								eval_expression=glob.compiledRules[eval_expression]

							charfile.write(ruleFields[2] + " " + eval(eval_expression) + "\n")

					else:
						charfile.write(ruleFields[2] + " " + ruleFields[3]  + "\n")
				elif ( ruleFields[0].upper() == "D" ):
					# Nothing to do, since the value won't be saved
					pass
				elif ( ruleFields[0].upper() == "T" ):
					if ( self.attributes.has_key(ruleFields[1])):
						charfile.write(ruleFields[2] + " " + self.attributes[ruleFields[1]] + "\n")
					elif (len(ruleFields) > 3 ):
						if ( ruleFields[3] != ""):
							#print "Debug: ", ruleFields
							charfile.write(ruleFields[2] + " " + ruleFields[3] + "\n")
					#else:
					#	print "Warning: Missing attribute for conversion rule", ruleFields, "ignoring rule..."
			charfile.write("}" + "\n")
			charfile.write("\n")

		except:
			print "Exception while converting with rule", self.charid, "possibly rule bug due to ", ruleFields, "with value", value
			traceback.print_exc(sys.stdout)

	def hasAttr(self, attr):
		return self.attributes.has_key(attr)

	def getAttr(self, attr):
		return self.attributes[attr]
			