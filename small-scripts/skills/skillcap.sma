const SK_SKILLCAP 7000	//!< maxximum skillcap, meant as the sum of all skills
const MAX_SKILL 1000	//!< maximum value of a skill (normal skills won't raise over 1000 anyway)
const SK_MINSKILL 2000	//!< skills under this value are not included in the skillcap

enum classes
{
	CLASS_WAR//,
	//CLASS_1,
	//CLASS_2,
	//CLASS_3
};

new classModifier[classes][SK_EXT_COUNT] =
{
//		alchemy	anatomy	anLore	itemid	armLore	parry	beg	black	bow	peace 	camping	carpent	cartogr	cooking	detect	entice	evalint	healing	fidhing	forens	herding	hiding	provoc	inscrip	lockpic	magery	magRes	tactics	snoop	music	poison 	archery	spirit	steal	tailor	taming	tasteid	tinker	track	veterin	sword	mace	fencing	wrest	lumber	mining	medit	stealth	remove	additional skills
/*WAR*/		{0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	/*0,	0*/}
//*CLASS 1*/	{0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	/*0,	0*/}	
//*CLASS 2*/	{0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	/*0,	0*/}
//*CLASS 3*/	{0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	/*0,	0*/}
};

enum races
{
	RACE_HUMAN//,
	//RACE_1,
	//RACE_2,
	//RACE_3
};

new raceModifier[races][SK_EXT_COUNT] =
{
//		alchemy	anatomy	anLore	itemid	armLore	parry	beg	black	bow	peace 	camping	carpent	cartogr	cooking	detect	entice	evalint	healing	fidhing	forens	herding	hiding	provoc	inscrip	lockpic	magery	magRes	tactics	snoop	music	poison 	archery	spirit	steal	tailor	taming	tasteid	tinker	track	veterin	sword	mace	fencing	wrest	lumber	mining	medit	stealth	remove	additional skills
/*HUMAN*/	{0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	/*0,	0*/}
//*RACE 1*/	{0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	/*0,	0*/}
//*RACE 2*/	{0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	/*0,	0*/}
//*RACE 3*/	{0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	/*0,	0*/}	
};

public handleSkillCap(const chr, const skill, const success, const result) 
{ 

	new class = 0;	//put here your function to get the class ex: class = getClass(chr);
	new race = 0;	//put here your function to get the race ex: race = getRace(chr);
	new cap = SK_MAXSKILL + classModifier[class][skill] + raceModifier[class][skill];
	new skillvalue = chr_getSkill(chr,skill);  

	//check the skillcap
	if (skillvalue >= cap || chr_getSkillCap(chr) >= SK_SKILLCAP)  return SKILLADV_DONTRAISE; 
	return SKILLADV_RAISE; 
} 

