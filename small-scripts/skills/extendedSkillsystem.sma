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
	if(skill < 0 || skill >= SK_COUNT) return -1;

	if(skill < SK_STD_COUNT) 
		return chr_getProperty(chr, CP_SKILL, skill);
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
	if(skill < 0 || skill >= SK_COUNT) return INVALID;
	
	if(skill < SK_STD_COUNT)
	{ 
		chr_setProperty(chr, CP_BASESKILL, skill, value);
		return OK;
	}
	#if ACTIVATE_EXTENDED_SKILLSYSTEM
	chr_setLocalIntVec(chr,CLV_ADDITIONALSKILLSBASE,skill - SK_STD_COUNT, value*100);
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
	if(skill < 0 || skill >= SK_COUNT) return -1;
	
	if(skill < SK_STD_COUNT)
		return chr_getProperty(chr, CP_BASESKILL, skill);
	
	return chr_getLocalIntVec(chr,CLV_ADDITIONALSKILLSBASE,skill - SK_STD_COUNT)/100;
}

public chr_getSkillcap(const chr)
{
	if(!isChar(chr)) return -1;
	
	new skillcap = chr_getProperty(chr,CP_TOTALSKILL);
	for(new sk = SK_STD_COUNT; sk < SK_COUNT; sk++)
		skillcap += chr_getSkill(chr,sk);
	return skillcap; 
}

//stop reading file if extended skillsystem is not activated
#if !ACTIVATE_EXTENDED_SKILLSYSTEM
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

public chr_trySkill(const chr, const sk, low, high, const raise)
{	
	//if it is a standard skill, call the native funciton
	if(sk < SK_STD_COUNT) return chr_checkSkill(chr,sk,low,high,raise); 
	
	//deads always fail
	if(chr_getProperty(chr,CP_DEAD)) return 0;

	//GMs always success (but don't gain skill)
	if (chr_isGM(chr)) return 1;

	
	new try = skillChance(chr,sk,low,high) - random(1001);
	if(try > 0)
	{
		if (__skillinfo[sk][_skUnhideOnUse])	chr_unhide(chr);
	}
	else	if (__skillinfo[sk][_skUnhideOnFail])	chr_unhide(chr);

	//raise skill if required
	if(raise) 
	{
		advanceSkill(chr,sk, try);
		updateSkillLevel(chr, sk);
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
	
	//value < low  		==> 0 < chance < 10%
	// low < value < high  	==> 10% < chance < 99%
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
	if(sk < SK_STD_COUNT) return;
	
	if(__onSkillAdvance(chr,sk,success,SKILLADV_RAISE) == SKILLADV_DONTRAISE) return;
	
	sk -= SK_COUNT;
	
	//0 < success < 1000  ==> skFailRaise < gain < skSuccessRaise
	//-1000 < success < 0 ==> 0 < gain < skFailRaise
	new gain = 0;
	if(success > 0)
		gain = __skillinfo[sk][_skFailRaise] + ((__skillinfo[sk][_skSuccessRaise] - __skillinfo[sk][_skFailRaise])*success)/1000;
	else 	
		gain = __skillinfo[sk][_skFailRaise] - (__skillinfo[sk][_skFailRaise]*success)/1000;
		
	chr_setLocalIntVec(chr,CLV_ADDITIONALSKILLSBASE,sk,chr_getBaseSkill(chr,sk) + gain);
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
	if(sk < SK_STD_COUNT) return;
	sk -= SK_STD_COUNT;
	new base = chr_getLocalIntVec(chr,CLV_ADDITIONALSKILLSBASE,sk)/100;
		
	//here you can modify the relationship between real value and base value
	new real = (
	((__skillinfo[sk][_skStr] * chr_getProperty(chr,CP_STRENGTH,CP2_REAL)) +
        (__skillinfo[sk][_skDex] * chr_getProperty(chr,CP_DEXTERITY,CP2_REAL))  +
        (__skillinfo[sk][_skInt] * chr_getProperty(chr,CP_INTELLIGENCE,CP2_REAL)))
        *(1000 - base))/30000;

	real += base;
	if(real < base) real = base;
	
	chr_setLocalIntVec(chr,CLV_ADDITIONALSKILLS,sk,real);
}

/*!
\author Fax
\fn createExtSkillVar(const chr)
\param chr: the character
\brief creates local vars for extended skillsystem

\note: this function doesn't exist if extended skillsystem is not activated
*/
public startExtSkillsystem(const chr)
{

#if ACTIVATE_EXTENDED_SKILLSYSTEM
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
	}
#else
	chr_delLocalVar(CLV_ADDITIONALSKILLS);
	chr_delLocalVar(CLV_ADDITIONALSKILLSBASE);
#endif

	printf("^n");
}

/*!
\author Fax
\fn initExtendedSkillsystem()
\since 0.82
\brief initializes the extended skillsystem

Loads skills2.xss, uses loadAdditionalSkills() to actually load skills
\return nothing
*/
public initExtendedSkillsystem()
{
#if !ACTIVATE_EXTENDED_SKILLSYSTEM
	return;
#endif
	
	log_message("Loading additional skills ...")
	
	//set default values
	for(new s = 0; s < SK_ADDITIONAL_MAX; s++)
	{
		__skillinfo[s][_skUnhideOnUse] = true;
		__skillinfo[s][_skUnhideOnFail] = true;
	}
	
	SK_ADDITIONAL_COUNT = xss_scanFile("scripts/skills2.xss","loadAdditionalSkills");
	
	if(SK_ADDITIONAL_COUNT == INVALID)
	{
		log_error("Unable to load additional skills from scripts/skills2.xss");
		return;
	}
	
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
	if(strcmp(currentXssSectionType,"SKILL")) return;
	if(currentXssSection <= 0) return;
	new sk = currentXssSection;
	
	if(sk < SK_STD_COUNT)
	{
		log_error("skills2.xss(%d): You can't modify standard skills (0 - %d) in skills2.sma, you can do it in skills.sma",line,SK_STD_COUNT - 1);
		return;
	}
	
	//check for out-of-range skills
	if(sk >= SK_STD_COUNT + SK_ADDITIONAL_MAX)
	{
		log_error("skills2.xss(%d): Skill number out of range %d",line,sk);
		return;
	}
	
	if(!strcmp(currentXssCommand,"NAME"))
	{
		strcpy(skillName[sk],currentXssValue);
		return;
	}
	
	if(!strcmp(currentXssCommand,"STR"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skStr] = str2Int(currentXssValue);
		return;
	}
	
	if(!strcmp(currentXssCommand,"INT"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skInt] = str2Int(currentXssValue);
		return;
	}
	
	if(!strcmp(currentXssCommand,"DEX"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skDex] = str2Int(currentXssValue);
		return;
	}
	
	if(!strcmp(currentXssCommand,"UNHIDEONUSE"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skUnhideOnUse] = str2Int(currentXssValue) != 0;
		return;
	}
	
	if(!strcmp(currentXssCommand,"UNHIDEONFAIL"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skUnhideOnFail] = str2Int(currentXssValue) != 0;
		return;
	}
	
	if(!strcmp(currentXssCommand,"SUCCESSRAISE"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skSuccessRaise] = str2Int(currentXssValue);
		return;
	}
	
	if(!strcmp(currentXssCommand,"FAILRAISE"))
	{
		__skillinfo[sk - SK_STD_COUNT][_skFailRaise] = str2Int(currentXssValue);
		return;
	}
	
	log_warning("Unrecognized command %s",currentXssCommand);
}
/*! @} */