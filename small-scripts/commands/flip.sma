/*!
\defgroup script_commands_flip 'flip
\ingroup script_commands
\brief flips an item

\b syntax: 'flip

The character can flip only items he can reach and handle (not too heavy), flipping an item causes
stamina loss depending on the item's weight.\n
SEERs and higher staff can flip everything without stamina loss.

@{
*/

/*!
\author Fax
\fn cmd_flip(const chr)
\param chr: the character who used the command
\since 0.82
\brief 'flip command start function

This function is called by sources on 'flip command detection.\n
You can change it in commands.txt.
*/
public cmd_flip(const chr)
{
	chr_message(chr,_,msg_commandsDef[130]);
	target_create(chr,_,_,_,"cmd_flip_targ");
}

/*!
\author Fax
\fn cmd_flip_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single item targetting and fliping
*/
public cmd_flip_targ(target, chr, object, x, y, z, unused, color)
{
	if(isItem(object))
	{
		/*
		//SEERs and higher players can flip every item without stamina loss
		if(chr_getProperty(chr,CP_PRIVLEVEL) >= PRIV_SEER)
		{
			itm_flip(object);
			return;
		}*/
		
		//check if character can move the item
		//ratio = -1: item too far
		//ratio = 0: item too heavy
		//ratio > 10: item can be moved
		new ratio = chr_canMoveItem(chr,object,true);
		
		//if  the item is too far return
		if(ratio == -1) return;
		
		//if the character is not strong enough to move the item, lose some stamina
		if(ratio == 0)
		{ 
			chr_setStamina(chr,chr_getStamina(chr) - 5)
			return;
		}
		
		//if the character can move the item he loses stamina
		//the heavier the item, the more stamina is lost
		chr_setStamina(chr,chr_getStamina(chr) - 50/ratio)
		itm_flip(object);
	}
	else chr_message(chr,_,msg_commandsDef[103]);
}

/*! }@ */