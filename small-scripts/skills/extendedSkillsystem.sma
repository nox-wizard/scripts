/*!
\defgroup script_extended_skills extended skillsystem
\ingroup script_skills

@{
*/

/*!
\author Fax
\ingroup script_skills
\fn chr_getSkill(const chr,const skill)
\param chr: the character whose skill is needed
\param skill: the skill to read
\brief reads a skill value of a character
\return the skill value or -1 if not a valid skill

Reads a skill value of a character, if extended skillsystem is active supports additional skills too
*/
public chr_getSkill(const chr,const skill)
{
	//check invalid skills
	if(skill < 0 || skill >= SK_COUNT) return -1;
	
	//return CP_SKILL forstandard skills
	if(skill < SK_STD_COUNT) 
		return chr_getProperty(chr, CP_SKILL, skill);
	
	//return local var for additional skills
	return chr_getLocalIntVec(chr,CLV_ADDITIONALSKILLS,skill - SK_STD_COUNT);
}

/*!
\author Fax
\ingroup script_skills
\fn chr_setSkill(const chr,const skill, const value)
\param chr: the character whose skill is needed
\param skill: the skill to read
\param value: the value to set
\brief sets a skill value of a character
\return OK or INVALID if not a valid skill
sets a skill value of a character, if extended skillsystem is active supports additional skills too
*/
public chr_setSkill(const chr,const skill, const value)
{
	//check invalide skill values
	if(skill < 0 || skill >= SK_COUNT) return INVALID;
	
	//if it's a standard skill set CP_BASESKILL
	if(skill < SK_STD_COUNT)
	{ 
		chr_setProperty(chr, CP_BASESKILL, skill, value);
		return OK;
	}

#if ACTIVATE_EXTENDED_SKILLSYSTEM
	//if it's an additional skill set local var
	//NOTE: base skill value is stored multiplied by 100 to have more precision in calculations
	chr_setLocalIntVec(chr,CLV_ADDITIONALSKILLSBASE,skill - SK_STD_COUNT, value*100);
	
	//update real skill value
	updateSkillLevel(chr,skill);
#endif
	return OK;
}

/*!
\author Fax
\ingroup script_skills
\fn chr_getSkill(const chr,const skill)
\param chr: the character whose skill is needed
\param skill: the skill to read
\brief reads a skill value of a character
\return the skill value or -1 if not a valid skill

Reads a skill base value of a character, if extended skillsystem is active supports additional skills too
*/
public chr_getBaseSkill(const chr,const skill)
{
	//check invalid skill values
	if(skill < 0 || skill >= SK_COUNT) return -1;
	
	//read standard skills from CP_BASESKILL
	if(skill < SK_STD_COUNT)
		return chr_getProperty(chr, CP_BASESKILL, skill);
	
	//read additionalskills from local var
	//NOTE: base skillvalue is stored multiplied by 100 so we must divide it before returning
	return chr_getLocalIntVec(chr,CLV_ADDITIONALSKILLSBASE,skill - SK_STD_COUNT)/100;
}

/*!
\author Fax
\fn chr_getSkillcap(const chr)
\param chr: the character
\since 0.82
\brief returns the sum of all skills
\return nothing
*/
public chr_getSkillSum(const chr)
{
	if(!isChar(chr)) return -1;
	
	//standard skillcap
	new skillcap = chr_getProperty(chr,CP_TOTALSKILL);
	
	//sum additional skills
	for(new sk = SK_STD_COUNT; sk < SK_COUNT; sk++)
		skillcap += chr_getSkill(chr,sk);
	return skillcap; 
}

public skill_isDirectlyUsable(skill)
{
	switch(skill)
	{
		case SK_ANATOMY..SK_ARMSLORE,SK_TAMING,SK_BEGGING,SK_CARTOGRAPHY,SK_DETECTINGHIDDEN,SK_EVALUATINGINTEL,SK_FORENSICS,SK_HIDING,SK_INSCRIPTION,SK_MEDITATION..SK_REMOVETRAPS,SK_POISONING,SK_PROVOCATION,SK_SPIRITSPEAK,SK_STEALING,SK_TASTEID,SK_TRACKING,SK_PEACEMAKING: return true;
	
	#if ACTIVATE_EXTENDED_SKILLSYSTEM
		case SK_STD_COUNT..SK_STD_COUNT + SK_ADDITIONAL_MAX: return __skillinfo[skill - SK_STD_COUNT][_skDirectlyUsable];
	#endif
	
	}
	return false;
}

//stop reading file if extended skillsystem is not activated.
#if !ACTIVATE_EXTENDED_SKILLSYSTEM
	
	//this function is define further in this file, but if the system
	//is not active this is the function implementation that will run
	public startExtSkillsystem(chr)
	{
		//delete local vars if character previously logged with extended skillsystem activated
		if(chr_isaLocalVar(chr,CLV_ADDITIONALSKILLS))
		{
			log_message("deleting additional skills (CLV_ADDITIONALSKILLS)");	
			chr_delLocalVar(chr,CLV_ADDITIONALSKILLS);
		}
		
		if(chr_isaLocalVar(chr,CLV_ADDITIONALSKILLSBASE))
		{
			log_message("deleting additional base skills (CLV_ADDITIONALSKILLSBASE)");
			chr_delLocalVar(chr,CLV_ADDITIONALSKILLSBASE);
		}
	}
	
	//this function is define further in this file, but if the system
	//is not active this is the function implementation that will run
	public initExtendedSkillsystem()
	{
		log_message("Extended skillsystem in not active");
		printf("^n");
	}
	#endinput
#endif



/*!
\author Fax
\fn chr_trySkill(const chr, const skill, const min, const max, const raise)
\param chr the character
\param skill: the skill to be checked
\param min: minimun skill required
\param max: maximum skill required
\param raise: true if skill should be raised 
\brief check if a skill action succeedes or fails
 
Use this function to check if a player succeedes in using a skill, if raise is set to true
the skill is raised. 
\note: this function is the same as chr_checkSkill but can be used with additional skills
\return  -1000 - 0: fail, 1 - 1000: success (1 - 1000 only for additional skills, the grater the value the better the try has succeded)
*/
public chr_trySkill(const chr, sk, low, high, const raise)
{	
	//if it is a standard skill, call the native funciton
	if(sk < SK_STD_COUNT) return chr_checkSkill(chr,sk,low,high,raise); 
	
	//deads always fail
	if(chr_getProperty(chr,CP_DEAD)) return 0;
	
	//try > 0 means success
	new chance = skillChance(chr,sk,low,high);
	new try = chance - random(1001);
	
	sk -= SK_STD_COUNT;
	
	//handle unhiding:
	//skUnhideOnUse: unhides character if the skill is used
	//skUnhideOnFail: unhides character ONLY on fail
	if (__skillinfo[sk][_skUnhideOnUse] || (try < 0 && __skillinfo[sk][_skUnhideOnFail]))	
		chr_unhide(chr);
	
	//raise skill if required
	if(raise) 
	{
		advanceSkill(chr,sk + SK_STD_COUNT,try);
		updateSkillLevel(chr,sk + SK_STD_COUNT);
	}	
	
	return try;	
}

/*!
\author Fax
\fn skillChance(const chr, const sk, const low, const high)
\param chr: the character
\param sk: the skill
\param low: minimum skill required
\param high: skill value at wich chance = 99%
\brief defines skill success chance
\return chance from 0 to 1000  (0 is 0% - 1000 is 100%)

Modify this function to define the chance of success of a skill
\note: this function doesn't exist if extended skillsystem is not activated
*/
public skillChance(const chr, const sk, const low, const high)
{
	new value = chr_getSkill(chr,sk);
	
	//chance vs skill rule:
	//value < low  		==> 0 < chance < 10%
	// low < value < high  	==> 10% < chance < 99% (linearly)
	//value > high  	==> chance = 99%
		
	if(value < low) return (value*100)/low;    
	if (value >= high || low == high ) return 990;
	return ((value - low)*890)/(high-low) + 100;
}

/*!
\author Fax
\fn advanceSkill(chr, sk, success)
\param chr: the character
\param sk: the skill
\param success: -1000 - 0 on fail, 1 - 1000 on success
\brief increases character's base skill value

Modify this function to define how the skills grow when they are used
\note: this function doesn't exist if extended skillsystem is not activated
*/
public advanceSkill(chr, sk, success)
{
	//standard skills raise in sources, not here
	if(sk < SK_STD_COUNT) return;
	
	//call skillcap handling function
	//if(__onSkillAdvance(chr,sk,success,SKILLADV_RAISE) == SKILLADV_DONTRAISE) return;
	
	sk -= SK_STD_COUNT;
	
	// gain vs. success rule:
	// success = -1000  ==> gain = skFailRaise
	// success = 1000   ==> gain = skSuccessRaise
	// -1000 < success < 1000 ==> skFailRaise < gain < skSuccessRaise (linear law)
	success += 1000;
	new gain = gain = __skillinfo[sk][_skFailRaise] + ((__skillinfo[sk][_skSuccessRaise] - __skillinfo[sk][_skFailRaise])*success)/2000;
	
	//scale gain to the base skill scale (100 times the skill value)
	//this is needed to have more precision
	gain *= 100; 
	
	//decrease gain as skill increases so skill will raise slower at higher skill levels
	//for the matematically interested ones: this gain decreasing rule gives the skill an exponential asinptotic behaviour towards 1000
	//for the more matematically interested: this is like the linear differential equation y'(x) = 1000(1 - gain)y(x) whose solution is y(x) = 1000(1 - exp(-gain*x)) where x is the number of skill trys
	new base = chr_getLocalIntVec(chr,CLV_ADDITIONALSKILLSBASE,sk);
	gain = (gain*(100000 - base))/100000;
	
	//always give a little gain on success, so skill will reach 1000
	//note: if skill > 1000 ==> gain < 0 ==> skill decreases ==> skill can't go over 1000
	if(success > 0 && gain == 0) gain = 1;
	chr_setLocalIntVec(chr,CLV_ADDITIONALSKILLSBASE,sk,chr_getLocalIntVec(chr,CLV_ADDITIONALSKILLSBASE) + gain);
}

/*!
\author Fax
\fn updateSkillLevel(chr, sk)
\param chr: the character
\param sk: the skill
\brief increases character's skill value, basing on base value and stats value

Modify this function to define how real skill value is calculated from base skill value
\note: this function doesn't exist if extended skillsystem is not activated
*/
public updateSkillLevel(chr, sk)
{
	//we don't want standard skills here
	if(sk < SK_STD_COUNT) return;
	
	sk -= SK_STD_COUNT;
	
	//base skill value
	new base = chr_getLocalIntVec(chr,CLV_ADDITIONALSKILLSBASE,sk)/100;
		
	//stats influence on real skill value:
	//stats raise the skillvalue towards 1000, higer stat influence (skStr skDex skInt)
	//and stat value make real skill go towards 1000
	//the limit is skStr = skDex = skInt = 100% and str = int = dex = 100, in that case real = 1000 independently from base
	new real = base + (
	((__skillinfo[sk][_skStr] * chr_getProperty(chr,CP_STRENGTH,CP2_REAL)) +
        (__skillinfo[sk][_skDex] * chr_getProperty(chr,CP_DEXTERITY,CP2_REAL)) +
        (__skillinfo[sk][_skInt] * chr_getProperty(chr,CP_INTELLIGENCE,CP2_REAL)))
        *(1000 - base))/30000;
	
	//real < base happens if base was > 1000
	if(real < base) real = base;
	
	chr_setLocalIntVec(chr,CLV_ADDITIONALSKILLS,sk,real);
}

/*!
\author Fax
\fn createExtSkillVar(const chr)
\param chr: the character
\brief handles extended skillsystemstartup for logging characters

This function is called in __charLogin(chr) function and that's the only location where it must be used.<br>
If extended skillsystem is active, this function creates 2 local vars to store skill values.<br>
If extended skillsystem is not active this function deletes the local vars.
\note: this function doesn't exist if extended skillsystem is not activated
*/
public startExtSkillsystem(const chr)
{
	//create local vars
	if(!chr_isaLocalVar(chr,CLV_ADDITIONALSKILLS))
	{
		log_message("Creating extended skillsystem for character %d ...",chr);
		chr_addLocalIntVec(chr,CLV_ADDITIONALSKILLS,SK_ADDITIONAL_COUNT,0);
		if(chr_getLocalVarErr() != VAR_ERROR_NONE)
		{
			chr_message(chr,_,"An error occurred while creating additional skills, please contact a GM");
			log_error("^nUnable to create local var %d (skills)for char %d - error: %d",CLV_ADDITIONALSKILLS,chr,chr_getLocalVarErr());
			return;	
		}
		
		chr_addLocalIntVec(chr,CLV_ADDITIONALSKILLSBASE,SK_ADDITIONAL_COUNT,0);
		if(chr_getLocalVarErr() != VAR_ERROR_NONE)
		{
			chr_message(chr,_,"An error occurred while creating additional skills, please contact a GM");
			log_error("^nUnable to create local var %d (base skills) for char %d - error: %d",CLV_ADDITIONALSKILLSBASE,chr,chr_getLocalVarErr());
			return;	
		}
				
		//update additional skill values
		for(new sk = SK_STD_COUNT; sk < SK_COUNT; sk++)
			updateSkillLevel(chr,sk);
		
		printf("^n");
	}

#if EXT_SKILLSYSTEM_TEST
	testExtendedSkillsystem(chr);
#endif
}

/*!
\author Fax
\fn initExtendedSkillsystem()
\since 0.82
\brief initializes the extended skillsystem

This function is called in __StartServer() function and that's the only location where it must be used.<br>
Loads skills2.xss, uses loadAdditionalSkills() to actually load skills
\return nothing
*/
public initExtendedSkillsystem()
{
	log_message("Loading additional skills ...")
	
	//set default values
	for(new s = 0; s < SK_ADDITIONAL_MAX; s++)
	{
		__skillinfo[s][_skUnhideOnUse] = true;
		__skillinfo[s][_skUnhideOnFail] = true;
	}
	
	//scan skills2.xss - the number of sections read is the number of additional skills loaded
	SK_ADDITIONAL_COUNT = xss_scanFile("scripts/skills2.xss","loadAdditionalSkills");
	
	//if there was an error reading the file ...
	if(SK_ADDITIONAL_COUNT == INVALID)
	{
		log_error("Unable to load additional skills from scripts/skills2.xss");
		return;
	}
	
	//if have too many additional skills loaded
	if(SK_ADDITIONAL_COUNT > SK_ADDITIONAL_MAX)
	{
		SK_ADDITIONAL_COUNT = SK_ADDITIONAL_MAX;
		log_warning("You have only %d additional skills available",SK_ADDITIONAL_MAX);
		log_warning("Increase SK_ADDITIONAL_MAX in 'small-scripts/skills/constant.sma' if you need more skills");
		log_warning("Skills out of range weren't loaded");
		printf("^n");
	}	
	
	//increase number of available skills
	SK_COUNT += SK_ADDITIONAL_COUNT;
	
	log_message("%d additional skills loaded, %d skills available",SK_ADDITIONAL_COUNT,SK_COUNT);
	printf("^n");
	
#if _SKILLS_DEBUG_
	if(SK_ADDITIONAL_COUNT > 0)
	{
		log_message("Loaded skills details:");
		for(new s = 0; s < SK_ADDITIONAL_COUNT; s++)
		{
			log_message("SKILL %d",s + SK_STD_COUNT);
			log_message("NAME %s",skillName[s + SK_STD_COUNT]);
			log_message("STR %d",__skillinfo[s][_skStr]);
			log_message("DEX %d",__skillinfo[s][_skDex]);
			log_message("INT %d",__skillinfo[s][_skInt]);
			log_message("SUCCESSRAISE %d",__skillinfo[s][_skSuccessRaise]);
			log_message("FAILRAISE %d",__skillinfo[s][_skFailRaise]);
			log_message("UNHIDEONUSE %d",__skillinfo[s][_skUnhideOnUse]);
			log_message("UNHIDEONFAIL %d",__skillinfo[s][_skUnhideOnFail]);
			printf("^n");
		}
	}
#endif
	printf("^n");
}

public loadAdditionalSkills(file,line)
{
	//skip invalid sections
	if(strcmp(currentXssSectionType,"SKILL")) return;
	
	//skip invalid section numbers
	if(currentXssSection <= 0) return;
	
	//the section number defines the skill
	new sk = currentXssSection;
	
	//standard skills can't be modified here
	if(sk < SK_STD_COUNT)
	{
		log_error("skills2.xss(%d): You can't modify standard skills (0 - %d) in skills2.sma, you can do it in skills.sma",line,SK_STD_COUNT - 1);
		return;
	}
	
	//skip out-of-range skills
	if(sk >= SK_STD_COUNT + SK_ADDITIONAL_MAX)
	{
		log_error("skills2.xss(%d): Skill number out of range %d",line,sk);
		return;
	}
	
	//read name
	if(!strcmp(currentXssCommand,"NAME"))
	{
		strcpy(skillName[sk],currentXssValue);
		return;
	}
	
	//read strength influence
	if(!strcmp(currentXssCommand,"STR"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skStr] = str2Int(currentXssValue);
		return;
	}
	
	//read intelligence influence
	if(!strcmp(currentXssCommand,"INT"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skInt] = str2Int(currentXssValue);
		return;
	}
	
	//read dexterity influence
	if(!strcmp(currentXssCommand,"DEX"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skDex] = str2Int(currentXssValue);
		return;
	}
	
	//read unhide on use
	if(!strcmp(currentXssCommand,"UNHIDEONUSE"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skUnhideOnUse] = str2Int(currentXssValue) != 0;
		return;
	}
	
	//read unhide on fail
	if(!strcmp(currentXssCommand,"UNHIDEONFAIL"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skUnhideOnFail] = str2Int(currentXssValue) != 0;
		return;
	}
	
	//read success raise
	if(!strcmp(currentXssCommand,"SUCCESSRAISE"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skSuccessRaise] = str2Int(currentXssValue);
		return;
	}
	
	//read fail raise
	if(!strcmp(currentXssCommand,"FAILRAISE"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skFailRaise] = str2Int(currentXssValue);
		return;
	}
	
	//read fail raise
	if(!strcmp(currentXssCommand,"FUNCTION"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skDirectlyUsable] = 1;
		strcpy(__skillFunctions[sk],currentXssValue];
		return;
	}
	
	//if we are here it means we found a wrong command
	log_warning("Unrecognized command %s",currentXssCommand);
}

#if EXT_SKILLSYSTEM_TEST
/*!
\author Fax
\fn testExtendedSkillsystem(chr)
\param chr: the character
\since 0.82
\brief perorms a skillsystem test

the test is the following:
a skill is set to 0 then its increased with all succesful skill checks, with all fail and with chr_try.<BR>
You can read the results in small-scripts/skills/skilltest.txt.
\return nothing
*/
public testExtendedSkillsystem(chr)
{
	if(SK_ADDITIONAL_COUNT == 0)
	{
		log_warning("There aren't additional skills to test");
		return;
	}
	log_message("testing skillsystem");
	new file = file_open("small-scripts/skills/skilltest.txt","w");
	
	file_write(file,"EXTENDED SKILLSYSTEM TEST^n");
	file_write(file,"This file is generated by testExtendedSkillsystem(chr)^n^n");
	file_write(file,"How to read results:^n");
	file_write(file,"The lists of numbers you see are the character's base skill values^n");
	file_write(file,"calculated with the method explained at the beginning of each test^n");
	file_write(file,"If you copy-paste this results in a graph-plotting software (like Excel)^n");
	file_write(file,"you can see the skill value vs. skill try plot, in different conditions^n^n");
	
	new buffer[100];
	for(new sk = SK_STD_COUNT; sk < SK_COUNT; sk++)
	{
		sprintf(buffer,"SKILL %d - %s - each try succedes (success = 1000)^n",sk,skillName[sk]);
		file_write(file,buffer);
		chr_setSkill(chr,sk,0);
		for(new i; chr_getBaseSkill(chr,sk) < 1000 && i < 1000; i++)
		{
			sprintf(buffer,"%d^n",chr_getBaseSkill(chr,sk));
			file_write(file,buffer);
			advanceSkill(chr,sk,1000);
		}	
		
		sprintf(buffer,"^nSKILL %d - %s - each try fails (success = 0)^n",sk,skillName[sk]);
		file_write(file,buffer);
		chr_setSkill(chr,sk,0);
		for(new i; chr_getBaseSkill(chr,sk) < 1000 && i < 1000; i++)
		{
			sprintf(buffer,"%d^n",chr_getBaseSkill(chr,sk));
			file_write(file,buffer);
			advanceSkill(chr,sk,0);
		}
		
		sprintf(buffer,"^nSKILL %d - %s - each try fails (success = -1000)^n",sk,skillName[sk]);
		file_write(file,buffer);
		chr_setSkill(chr,sk,0);
		for(new i; chr_getBaseSkill(chr,sk) < 1000 && i < 1000; i++)
		{
			sprintf(buffer,"%d^n",chr_getBaseSkill(chr,sk));
			file_write(file,buffer);
			advanceSkill(chr,sk,-500);
		}
		
		sprintf(buffer,"^nSKILL %d - %s - random tries ( chr_trySkill(chr,skill,500,950,true) ) ^n",sk,skillName[sk]);
		file_write(file,buffer);
		chr_setSkill(chr,sk,10); //skill = 0 won't make the skill grow at all
		for(new i; chr_getBaseSkill(chr,sk) < 1000 && i < 1000; i++)
		{
			sprintf(buffer,"%d^n",chr_getBaseSkill(chr,sk));
			file_write(file,buffer);
			chr_trySkill(chr,sk,500,950,1);
		}
	}
	
	file_close(file);
	log_message("done^n");
}
#endif
/*! @} */