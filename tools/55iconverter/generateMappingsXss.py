#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os,sys,getopt,re, glob

true = 1==1
false = 0==1
glob.traceLevel=0
def getOpts():
	opts, args = getopt.getopt(sys.argv[1:], "Dhf:i:", ["debug", "help", "file=", "import="])
	for opt, arg in opts:
		if opt == "-i":
			glob.sourcedir=arg
		if opt == "-f":
			glob.noxfile=arg
		if opt == "-D":
			glob.traceLevel=1

def loadFile (filename):
	linebuffer=[]
	if glob.traceLevel:
		print "Loading file", filename
	if ( os.path.isdir(filename)):
		return linebuffer
	try:
		filehandle = open (filename, "r")
		linebuffer = filehandle.readlines()
	except:
		print "Error loading file", filename
	if glob.traceLevel:
		print "File loaded"
	return linebuffer

def loadDirContents(directory):
	if ( not directory.endswith(os.sep)):
		directory+=os.sep
	print "Dir", directory
	inputdir=os.listdir(directory)
	if ( directory.startswith(glob.sourcedir)):
		subdir=directory[len(glob.sourcedir)+1:]
	for file in inputdir:

		if ( os.path.isdir(directory + file) and file.find("CVS") < 0):
			loadDirContents(directory + file)
		elif ( os.path.isfile(directory + file)):
			if ( os.path.basename(directory + file) not in glob.script_files and os.path.basename(directory + file).upper().endswith(".SCP")):
				if ( os.path.basename(directory + file) == "spheretables.scp"): continue
				if ( os.path.basename(directory + file) == "spheredefs.scp"): continue
				glob.script_files.append(glob.sourcedir + os.sep + subdir + file)

def readNoxItems(noxItemFile):
	if ( not os.path.isfile(noxItemFile)):
		print "File " + noxItemFile + " not found!"
		sys.exit(0)
	itemFile = open( noxItemFile, "r")
	linebuffer = itemFile.readlines()
	lineindex=0
	id=None
	while ( lineindex < len(linebuffer)):
		line = linebuffer[lineindex].strip()
		if ( line == None or line == ""):
			lineindex +=1
			continue
		if ( line.startswith("#") or line.startswith("//")):
			lineindex +=1
			continue
		if ( line.upper().startswith("SECTION ITEM ")):
			itemName=line[line.upper().index("SECTION ITEM ")+len("SECTION ITEM "):]
			itemName.strip()
			lineindex +=1
			continue
		if ( line.startswith("ID ")):
			id=line[line.index("ID ")+len("ID "):].upper()
		if ( line.startswith("}")):
			print "Adding map ", id, "to", itemName
			if ( glob.noxItems.has_key(id)):
				glob.noxItems[id].append(itemName)
			elif ( id != None ):
				if ( not id.startswith("0")):
					id="0"+id
				glob.noxItems[id]=[itemName]
			itemName=None
			lineindex +=1
			continue
		lineindex +=1
	return

glob.allSphereIds={}
def parseSphereScript(linebuffer):
	lineindex=0
	itemname=None
	id=None
	while ( lineindex < len(linebuffer)):

		line = linebuffer[lineindex].strip()
		if ( line == None or line == ""):
			lineindex +=1
			continue
		if ( line.startswith("#") or line.startswith("//")):
			lineindex +=1
			continue

		if ( line.startswith("[")):
			if ( (id == None) and (itemname == None) ):
				pass
			else:
				if ( itemname == None ):
					itemname=id
				if ( id == None and itemname.startswith("0")):
					id=itemname

				if ( not id.startswith ("0")):
					# the id is the same as another object
					if ( glob.allSphereIds.has_key(id) ):
						id=glob.allSphereIds[id]
						glob.allSphereIds[itemname]=id
				if ( glob.spheredefs.has_key(id) ):
					glob.spheredefs[id].append(itemname)
				else:
					glob.spheredefs[id]=[itemname]
				itemname=None
				id=None
		if ( line.upper().startswith("[ITEMDEF ")):

			temp=line[line.upper().index("[ITEMDEF ")+len("[ITEMDEF "):line.upper().index("]")].upper()
			if ( temp.startswith("0")):
				# its an id
				id=temp
			else:
				itemname=temp
			lineindex +=1
			continue
		if ( line.upper().startswith("DEFNAME") and itemname != None):
			id=itemname
			itemname=line[line.upper().index("DEFNAME")+len("DEFNAME "):].upper()
			lineindex +=1
			continue
		if ( line.upper().startswith("TYPE") ):
			type=line[line.upper().index("TYPE")+len("TYPE "):].upper()
			if ( type.upper() == "T_MULTI" or type.upper() == "T_EQ_SCRIPT"):
				id=None
				itemname=None
			lineindex +=1
			continue
		if ( line.upper().startswith("ID") and itemname != None):
			id=line[line.upper().index("ID")+len("ID "):].upper()
			lineindex +=1
			continue
		lineindex +=1
	if ( id == None and itemname == None ):
		return
	if ( id == None ):
		# itemname is id value
		id=itemname
		if ( glob.spheredefs.has_key(id) ):
			glob.spheredefs[id].append(itemname)
		else:
			glob.spheredefs[id]=[itemname]
	else:
		if ( glob.spheredefs.has_key(id) ):
			glob.spheredefs[id].append(itemname)
		else:
			glob.spheredefs[id]=[itemname]

def compareItems():
	for itemid in glob.noxItems.keys():
		myNoxArray=glob.noxItems[itemid]
		# does the sphere definitions have a declaration with the same id ?
		if ( glob.spheredefs.has_key(itemid.upper())):
			if ( len(myNoxArray) > 1 ):
				print "MULTIPLE"
			mySphereArray=glob.spheredefs[itemid]
			if ( len(myNoxArray) == 1 and len(mySphereArray) > 1):
				print "MULTIPLE"
			if ( len(mySphereArray) > 0):
				for noxitem in myNoxArray:
					for sphereitem in mySphereArray:
						print "[" + sphereitem + "]"
						print "MAPPING " + noxitem
						print ""

def main():
	glob.sourcedir=None
	glob.noxdir=None
	glob.missing=[]
	glob.script_files=[]
	glob.spheredefs={}
	glob.noxItems={}

	getOpts()
	if ( glob.sourcedir == None ):
		print "Sphere directory has to be defined by using -i <directory>"
		usage()
		sys.exit(0)

	if ( glob.noxfile == None ):
		print "Nox Items file has to be defined by using -f <file>"
		usage()
		sys.exit(0)

	readNoxItems(glob.noxfile)

	if ( glob.sourcedir != None ):
		loadDirContents(glob.sourcedir)

	for spherescript in glob.script_files:
		content=loadFile(spherescript)
		parseSphereScript(content)
	compareItems()

main()