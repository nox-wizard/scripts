public __onSkillAdvance(chr,skill,success,raise)
{
	new skillvalue = chr_getBaseSkill(chr,skill);
	new class = chr_getClass(chr);
	new race = chr_getRace(chr);
	
	//calculate maximum skill value
	new maxskill = MAX_SKILL_VALUE + __raceSkillCapModifier[skill][race] + __classSkillCapModifier[skill][class];
	
	if(skillvalue >= maxskill) 
		return SKILLADV_DONTRAISE;
	return SKILLADV_RAISE;
}