/*!
\defgroup script_extended_skills extended skillsystem
\ingroup script_skills
@{
*/

#define ACTIVATE_EXTENDED_SKILLSYSTEM 1	//!< set to 1 to activate the extended skillsystem
#define SK_ADDITIONAL_COUNT 1		//number of additional skills
#define CLV_ADDITIONALSKILLS 9998	//<! local variable to store additional skill values

#define CLV_ADDITIONALSKILLSBASE 9997	//<! local variable to store addition base skill values

#define SK_EXT_COUNT SK_COUNT + SK_ADDITIONAL_COUNT  //total number of skills

enum __skill
{
	_skFailRaise,		//<! how much the base skill raises on failure 
	_skSuccessRaise,	//<! how much the base skill raises on success 
	_skStr,			//<! how much strength influences skill value in %
	_skDex,			//<! how much dex influences skill value in %
	_skInt,			//<! how much int influences skill value in %
	_skUnhideOnFail,	//<! true if character is unhidden when fails skill check
	_skUnhideOnUse,		//!< true if charcater is unhidden when he uses the skill
	_skName: 30,		//!< skill name
}	//<! skill data type, you can modify this to your needs, bt remember to update __skillinfo[][] too

new __skillinfo[SK_ADDITIONAL_COUNT][__skill] =
{
	{50,100,10,10,10,true,true,"lamering" }
} //<!! mixed array with additional skills characteristics, add a row for each new skill


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
	if(skill < 0) return -1;
#if !ACTIVATE_EXTENDED_SKILLSYSTEM
	if(skill >= SK_COUNT) return -1;
	return chr_getProperty(chr, CP_SKILL, skill);
#else
	if(skill < SK_COUNT) return chr_getProperty(chr, CP_SKILL, skill);
	if(skill >= SK_EXT_COUNT) return -1;
	return chr_getLocalIntVec(chr,CLV_ADDITIONALSKILLS,skill - SK_COUNT);
#endif
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
	if(skill < 0) return INVALID;
	
#if !ACTIVATE_EXTENDED_SKILLSYSTEM
	if(skill >= SK_COUNT) return INVALID;
	chr_setProperty(chr, CP_BASESKILL, skill, value);
	return OK;
#else
	if(skill < SK_COUNT) chr_setProperty(chr, CP_BASESKILL, skill, value);
	if(skill >= SK_EXT_COUNT) return INVALID;
	chr_setLocalIntVec(chr,CLV_ADDITIONALSKILLSBASE,skill - SK_COUNT, value*100);
	return OK;
#endif
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
	if(skill < 0) return -1;
	
#if !ACTIVATE_EXTENDED_SKILLSYSTEM
	if(skill >= SK_COUNT) return -1;
	return chr_getProperty(chr, CP_BASESKILL, skill);
#else
	if(skill < SK_COUNT)	return chr_getProperty(chr, CP_BASESKILL, skill);
	if(skill >= SK_EXT_COUNT) return -1;
	return chr_getLocalIntVec(chr,CLV_ADDITIONALSKILLSBASE,skill - SK_COUNT)/100;
#endif
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
	if(sk < SK_COUNT) return chr_checkSkill(chr,sk,low,high,raise); 
	
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
	if(sk < SK_COUNT) return;
	
	//stop gaining skill at 1000
	if(chr_getSkill(chr,sk) >= 1000) return;
	
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
	if(sk < SK_COUNT) return;
	sk -= SK_COUNT;
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
	
	if(!chr_isaLocalVar(chr,CLV_ADDITIONALSKILLS))
	{
		printf("Creating extended skillsystem for character %d ...",chr);
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
		for(new sk = SK_COUNT; sk < SK_EXT_COUNT; sk++)
			updateSkillLevel(chr,sk);

		printf("[DONE]^n");
	}
}

/*! @} */