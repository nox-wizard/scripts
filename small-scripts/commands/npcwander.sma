/*!
\defgroup script_command_npcwander 'npcwander
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_npcwander
\brief defines character's wander mode

<B>syntax:<B> 'npcwander
*/
public cmd_npcwander(const chr)
{
	readCommandParams(chr);
	new wander;
	switch(__cmdParams[0][0])
	{
		case 'a': wander = WANDER_AMX;
		case 'r': wander = WANDER_FREELY_BOX;
		case 'c': wander = WANDER_FREELY_CIRCLE;
		case 'n': wander = WANDER_NOMOVE;
		case 'f': 
			switch(__cmdParams[0][1])
			{
				case 'o': wander = WANDER_FOLLOW;
				case 'l': wander = WANDER_FLEE;
				case 'r': wander = WANDER_FREELY;
			}
	}
	
	chr_message(chr,_,msg_commandsDef[188]);
	target_create(chr,wander,_,_,"cmd_npcwander_targ");
	
}

/*!
\author Fax
\fn cmd_npcwander_targ(target, chr, object, x, y, z)
\params all standard target callback params
\brief handles single object targetting and wiping
*/
public cmd_npcwander_targ(target, chr, object, x, y, z, unused, wander)
{
	if(isChar(object))
	{		
		chr_setProperty(object,CP_NPCWANDER,_,wander);
		chr_addLocalIntVar(chr,CLV_CMDTEMP,object);
		switch(wander)
		{
			case WANDER_FREELY_BOX: getRectangle(chr,"cmd_npcwander_rect");
			case WANDER_FREELY_CIRCLE: getRectangle(chr,"cmd_npcwander_rect")
			case WANDER_FOLLOW: target_create(chr,object,_,_,"cmd_npcwander_follow");
		}
	}
	else 
	{ 
		chr_message(chr,_,msg_commandsDef[189]); 
		return; 
	}
}

public cmd_npcwander_rect(chr,x0,y0,x1,y1)
{
	new npc = chr_getLocalIntVar(chr,CLV_CMDTEMP);
	chr_delLocalVar(chr,CLV_CMDTEMP);
	
	chr_setProperty(npc,CP_FPOS1_NPCWANDER,CP2_X,x0);
	chr_setProperty(npc,CP_FPOS1_NPCWANDER,CP2_Y,y0);
	chr_setProperty(npc,CP_FPOS1_NPCWANDER,CP2_Z,map_getZ(x0,y0));
	chr_setProperty(npc,CP_FPOS2_NPCWANDER,CP2_X,x1);
	chr_setProperty(npc,CP_FPOS2_NPCWANDER,CP2_Y,x1);
	
	chr_message(chr,_,msg_commandsDef[190],x0,y0,x1,y1)
}

public cmd_npcwander_follow(target,chr,object,x,y,z,unused,npc)
{
	if(isChar(object))
		chr_setProperty(npc,CP_FTARG,_,object);
	else 
	{ 
		chr_message(chr,_,msg_commandsDef[32]); 
		return; 
	}
}
/*! }@ */