#!/usr/bin/python
# -*- coding: utf-8 -*-

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

def readSphereAccounts(sphereDir):
	if ( not os.path.isfile(sphereDir + '/sphereaccu.scp')):
		print "Datei ", sphereDir + '/sphereaccu.scp', "wurde nicht gefunden!"
		sys.exit(0)
	accFile = open (sphereDir + '/sphereaccu.scp',"r")

	glob.linebuffer=accFile.readlines()
	accountCounter=0
	glob.lineCounter=0
	while ( glob.lineCounter < len(glob.linebuffer) ):
		line=glob.linebuffer[glob.lineCounter].strip()
		if ( line==None or len(line) == 0 ):
			glob.lineCounter+=1
			continue
		if ( line.strip().startswith("[") ):
			accName=line[line.index("[")+1:line.index("]")]
			privilege, accPass, totalconnecttime, lastconnecttime, lastchar, firstconnectdate, firstip, lastconnectdate, lastip=readAccount(accName)
			saveAccount(accName, accPass, privilege, lastconnectdate, lastip)
			continue

		glob.lineCounter+=1

def saveAccount(accName, accPass, privilege, lastconnectdate, lastip):

	if ( accName == None ):
		return
	if (accPass == None):
		accPass=""
	glob.accountfile.write("SECTION ACCOUNT " + repr(glob.accountCounter) + "\n")
	glob.accountfile.write("{\n")
	glob.accountfile.write("NAME " + accName + "\n")
	glob.accountfile.write("PASS " + accPass + "\n")
	glob.accountfile.write("}\n")
	glob.accountCounter+=1

def readAccount(accName):
	glob.lineCounter+=1
	privilege = None
	accPass = None
	totalconnecttime = None
	lastconnecttime=None
	lastchar=None
	firstconnectdate=None
	firstip=None
	lastconnectdate=None
	lastip=None

	while ( glob.lineCounter < len(glob.linebuffer) ):
		line=glob.linebuffer[glob.lineCounter].strip()
		if ( line.startswith("[") ):
			break
		if ( 	line.startswith("PRIV=")):
			privilege=line[line.index("=")+1:]
		if ( line.startswith("PASSWORD=")):
			accPass=line[line.index("=")+1:]
		if ( line.startswith("LASTCONNECTTIME=")):
			lastconnecttime=line[line.index("=")+1:]
		if ( line.startswith("LASTCHARUID=")):
			lastchar=line[line.index("=")+1:]
		if ( line.startswith("FIRSTCONNECTDATE=")):
			firstconnectdate=line[line.index("=")+1:]
		if ( line.startswith("FIRSTIP=")):
			firstip=line[line.index("=")+1:]
		if ( line.startswith("LASTCONNECTDATE=")):
			lastconnectdate=line[line.index("=")+1:]
		if ( line.startswith("LASTIP=")):
			lastip=line[line.index("=")+1:]
		if ( line.startswith("LANG=")):
			lang=line[line.index("=")+1:]
		glob.lineCounter+=1

	return privilege, accPass, totalconnecttime, lastconnecttime, lastchar, firstconnectdate, firstip, lastconnectdate, lastip


def usage():
	print "Usage:"
	print "account_converter -s <Sphere Directory> -t <Nox Wizard Account.adm file (full path)> [-d]"
	print "-s <Sphere Directory> :	contains the source path of the sphere account directory, mandatory"
	print "-t <Target Directory> : 	the path and filename of the nox wizard account file"

def main():
	adminname=None
	adminpass=None
	targetfile=""
	sourcedir=""
	glob.lineCount=0
	if ( len(sys.argv) < 2 ):
		usage()
		sys.exit()
	if ( sys.argv[1] == None or sys.argv[1]=="" ):
		usage()
		sys.exit();
	opts, args = getopt.getopt(sys.argv[1:], "dhs:t:a:p:", ["debug", "help", "sourcedir=", "target="])
	for opt, arg in opts:
		if opt == "-d":
			glob.debug=true
		if opt == "-h":
			usage()
			sys.exit()
		if opt == "-s":
			sourcedir=arg
			if ( not os.path.isdir(sourcedir)):
				print "Source directory does not exist or is not a directory!"
				sys.exit()
		if opt == "-t":
			targetfile=arg

		if opt == "-a":
			adminname=arg
		if opt == "-p":
			adminpass=arg
	if ( adminname == None or adminname == "" ):
		print "No adminname given, defaulting to admin"
		adminname="admin"
	if ( adminpass == None or adminpass == ""):
		print "No adminpassword given, defaulting to admin"
		adminpass="admin"
	if ( not os.path.isfile(targetfile)):
		print "Targetfile does not exist or is not a file!"
		sys.exit()
	if ( 	os.path.isfile(targetfile+".old")):
		os.remove(targetfile+".old")
	if ( os.path.isfile(targetfile)):
		os.rename(targetfile, targetfile + ".old")
	glob.accountCounter=0
	glob.accountfile=open (targetfile, "w")
	saveAccount(adminname, adminpass, "","","")
	readSphereAccounts(sourcedir)
main()