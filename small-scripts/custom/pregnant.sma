const SexVar = 1011; //sex (1 female, 0 male)
const fertileduration = 1012; //stores fertility duration if no male is close
const animalrace = 1013; //race
const pregnancy = 1014; //pregnancy (1 is yes), fo later checks e.g.
const adultcheck = 1015; //is adult (0 child, 1 adult)
const motherserial = 1016; //serial of motheranimal for birth-teleport


const Delay_fertile_firsttime = 864000; //10 days after birth becomes adult
const Delay_fertile = 172800; //all 2 days fertile
const Delay_fertileduration = 180; //all 3 minutes ask for male horse close
const Delay_pregnant = 43200; //12h for pregnancy
const NUM_FERTILE = 20; //60 minutes fertile


public _fertile(const c) //oncreation animal (spawn animal as young one or adult)
{

tempfx_activate(_, c, c, 0, Delay_fertile_firsttime,funcidx("fertiletimerfirst"));

}


public fertiletimerfirst(const animal, const dest, const power, const mode) //first time fertile getting
{

if(mode != TFXM_END) return;
//get sex and make adult
new sex = chr_getLocalIntVar(animal, SexVar);
if(sex == 1)
{

chr_setProperty(animal, CP_STR_TITLE, _ , "adult, female");
chr_setLocalIntVar(animal, adultcheck, 1);
tempfx_activate(_, animal, animal, 0, Delay_fertile,funcidx("fertiletimer"));

}
else if (sex == 0)
{

chr_setProperty(animal, CP_STR_TITLE, _ , "adult, male");
chr_setLocalIntVar(animal, adultcheck, 1);

}

}


public fertiletimer(const animal, const dest, const power, const mode) //source is adult animal
{

if(mode != TFXM_END) return;
//animal is fertile -> in Range check for male animal, LOS-check, ridding check, frozen-check for male: if all ok -> animal is pregnant
new mountedfemale = chr_getProperty( animal, CP_MOUNTED )
if( mountedfemale == 1)//is mounted
{

countfertile( animal);

}
new race = chr_getLocalIntVar(animal, animalrace);
new sex = chr_getLocalIntVar(animal, SexVar);
new female_x = chr_getProperty(animal, CP_POSITION, CP2_X);

new female_y = chr_getProperty(animal, CP_POSITION, CP2_Y);
new female_z = chr_getProperty(animal, CP_POSITION, CP2_Z);


new set = set_create(); // creating a new set
// fill the set with all chars in range
set_addNpcsNearXY( set, female_x,female_y,10);


//set_rewind reinitialize internal set index, so now point to first element
//!set_isEmpty check if is not at end of set


for( set_rewind(set); !set_end(set);)
{

new cc=set_getChar(set); // get the current set character and move internal index to next
if(cc!=INVALID && cc!=animal) // if is valid char
{

 new isadult = chr_getLocalIntVar(cc, adultcheck)
 if( ( isadult == 1) && !(chr_isHuman(cc)) && ( race == chr_getLocalIntVar(cc, animalrace)) && (chr_getLocalIntVar(cc, SexVar) == 0)) //adult animale, npc, no human, same race, male
 {

new male_x = chr_getProperty(cc, CP_POSITION, CP2_X);
new male_y = chr_getProperty(cc, CP_POSITION, CP2_Y);
new male_z = chr_getProperty(cc, CP_POSITION, CP2_Z);
new females = animal;
new mountedmale = chr_getProperty( cc, CP_MOUNTED );
if( (chr_lineOfSight(females, female_x, female_y, female_z, male_x, male_y, male_z, 63) == 1) && (mountedmale == 0) && (chr_getProperty(cc, CP_PRIV2) != 2) ) //nothing between both and male is not mounted too and male is not frozen
{
 //allright then, lets get the female pregnant
chr_setLocalIntVar(animal, pregnancy, 1); //animal is pregnant in first stage
shadowchild(animal, cc);
return;

}
 
}

}

}
countfertile(animal);
set_delete(set); // close the set ( very important )

}


public countfertile(const animal)
{

//get number of runs from NPC
new i = chr_getLocalIntVar(animal, fertileduration);
if( i < NUM_FERTILE)
{

 i++;
 //store new number of runs at npc
 chr_setLocalIntVar(animal, fertileduration, i);
 tempfx_activate(_, animal, animal, 0, Delay_fertileduration,funcidx("fertiletimer")); //ask in 3 minutes again if male horse is close

}
else if(i == NUM_FERTILE) //60 minutes long no male horse there - again infertile for 2 days
{

 chr_setLocalIntVar(animal, fertileduration, 0);
 tempfx_activate(_, animal, animal, 0, Delay_fertile,funcidx("fertiletimer")); //get in 2 days fertile again

}

}


public shadowchild( const female, const male )
{

new animalscript = chr_getProperty( female, CP_SCRIPTID);

// new animal is spawned invis at 10,10,10 and frozen, has propertie mixed from parents and is named "youngster" by title

new animalnew = chr_addNPC(animalscript, 10, 10, 10);

chr_setProperty(animalnew,CP_PRIV2,_,2); //freeze

//chr_setProperty(animalnew,CP_VISIBLE,_,2); //invis

chr_setLocalIntVar(animalnew, motherserial, female);

new fint = chr_getProperty(female, CP_INTELLIGENCE, CP2_INTREAL);
new fstr = chr_getProperty(female, CP_STRENGHT, CP2_STRREAL);
new fdex = chr_getProperty(female, CP_DEXTERITY, CP2_DEXREAL);

new mint = chr_getProperty(male, CP_INTELLIGENCE, CP2_INTREAL);
new mstr = chr_getProperty(male, CP_STRENGHT, CP2_STRREAL);
new mdex = chr_getProperty(male, CP_DEXTERITY, CP2_DEXREAL);


new decision;
new value;
new valueother;
new babyprop;

//Int
decision = random(1);
switch(decision)
{
case 0:
{
value = fint;
valueother = mint;
}
default:
{
value = mint;
valueother = fint;
}
}

new addit = random(20);

if(1 <= addit<= 10)
{
babyprop = (value + (valueother*addit)/value)
}
else if(11 <= addit <= 20)
{
addit = addit - 10;
babyprop = (value - (valueother*addit)/value)
}
else babyprop = value;

chr_setProperty(animalnew, CP_INTELLIGENCE, CP2_INTREAL, babyprop);

//STR
decision = random(1);
switch(decision)
{
case 0: 
{
value = fstr;
valueother = mstr;
}
default:
{
value = mstr;
valueother = fstr;
}
}

addit = random(20);
if(1 <= addit<= 10)
{
babyprop = (value + (valueother*addit)/value)
}
else if(11 <= addit <= 20)
{
addit = addit - 10;
babyprop = (value - (valueother*addit)/value)
}
else babyprop = value;
chr_setProperty(animalnew, CP_STRENGHT, CP2_STRREAL, babyprop);
//DEXdecision = random(1);

switch(decision)
{
case 0:
{
value = fdex;
valueother = mdex;
}
default:
{
value = mdex;
valueother = fdex;
}
}

addit = random(20);
if(1 <= addit<= 10)
{
babyprop = (value + (valueother*addit)/value)
}
else if(11 <= addit <= 20)
{
addit = addit - 10;
babyprop = (value - (valueother*addit)/value)
}
else babyprop = value;
chr_setProperty(animalnew, CP_DEXTERITY, CP2_DEXREAL, babyprop);

new chance = random(100);
//sex is decided
if (chance < 30) //female
{
	chr_setLocalIntVar(animalnew, SexVar, 1);
	chr_setProperty(animalnew, CP_STR_TITLE, _ , "youngster, female");

}
else
{
	chr_setLocalIntVar(animalnew, SexVar, 0);
	chr_setProperty(animalnew, CP_STR_TITLE, _ , "youngster, male");

}
tempfx_activate(_, animalnew, animalnew, 0, Delay_pregnant,funcidx("pregnanttimer")); //pregnancy timer is set to make sure the invis animal is born some time later
}

public pregnanttimer(const animal, const dest, const power, const mode) //animal is invis baby animal
{
if(mode != TFXM_END) return; //getscriptID and position
new female = chr_setLocalIntVar(animal, motherserial);
new female_x = chr_getProperty(animal, CP_POSITION, CP2_X);
new female_y = chr_getProperty(animal, CP_POSITION, CP2_Y);
new female_z = chr_getProperty(animal, CP_POSITION, CP2_Z);
chr_moveTo(animal, female_x, female_y, female_z);
chr_setProperty(animal,CP_PRIV2,_,0);
 //unfreeze//chr_setProperty(animal,CP_VISIBLE,_,0);
 //visiblechr_setProperty(animal, CP_FTARG, female);
chr_setLocalIntVar(female, pregnancy, 0);
tempfx_activate(_, female, female, 0, Delay_fertile,funcidx("fertiletimer"));
}
