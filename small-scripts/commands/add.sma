/*!
\author Fax
\fn cmd_add(const chr)
\brief adds objects to the world

<B>syntax:</B> 'add [scriptID][amount]
<B>command params:</B>
<UL>
<LI> scriptID: scriptID ($item_/$npc_/number) of the object 
<LI> amount: how much objects you want (default = XSS value for items, 1 for npcs)
</UL>

If no params are specified the add menu is opened.<BR>
\todo make this function work when commands are done in sources
<br>
*/
public cmd_add(const chr)
{
	new def[50], type[6];
	new amount = INVALID;
	
	if()
	{
		gumps_addMenu(chr);
		return;		
	}
	
	substring(def,0,4,type,false);
	if(!strcmp(type,"$item")) //add an item
	{
		new item = itm_createInBpDef(def,chr,amount);
		chr_message(chr,_,"Item %d created",item);
		return;
	}
	
	amount = 1;
	if(!strcmp(type,"$npc_"))  //add an NPC
	{
		chr_message(chr,_,"click to position the NPC");
		target_create(chr,getIntFromDefine(def),amount,_,"cmd_add_targ");
		return;
	}
	
	chr_message(chr,_,"You must pass as parameter scriptID ($item_ $npc_)");
}

/*!
\author Fax
\fn cmd_add_targ(target, chr, object, x, y, z, unused1, scriptID)
\brief handles the area targetting
*/
public cmd_area_targ(target, chr, object, x, y, z, unused1, scriptID)
{
	if(x != INVALID && y != INVALID && z != INVALID)
	{
		new amount = target_getProperty(target,TP_BUFFER,1);
		for(new i = 0; i < amount; i++)
		{
			new npc = chr_addNPC(scriptID,x,y,z);
			chr_message(chr,_,"Character %d created",npc);
		}
		return;
	}
	chr_message(chr,_,"You must target a map location");
}
