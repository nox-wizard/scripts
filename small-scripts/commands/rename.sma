/*!
\defgroup script_command_rename 'rename
\ingroup script_commands

@{
*/

/*!
\author Horian(const obj)
\fn cmd_rename
\brief sets names of an item or char (name, titke, disabledmessage, description etc.)

<B>syntax:<B> 'rename [what] [name]

the targetted object will be renamed
what:
creator = char: nothing, item: creator
desc = char: nothing, item: description, invis ingame at click
hidden = item name 2 (hidden name of magic items), char: nothing
message = disabled message
name = char or item name
title = char title, item: nothing
*/
static tempStr[512] 

public cmd_rename(const chr)
{
	readCommandParams(chr);
	
	new prop = -1000;
	readProp(chr,prop);
	
	chr_getSpeech(chr, tempStr);
	trim(tempStr);
	
	//store parameters to be read by the callback
	chr_addLocalStrVar(chr,CLV_CMDTEMP,tempStr);
	
	chr_message(chr,_,"Rename whom or what?");
	target_create(chr,prop,_,_,"cmd_rename_targ");
}

/*!
\author Horian
\fn cmd_rename_targ(target, chr, object, x, y, z, unused, area)
\params all standard target callback params
\brief handles single character targetting and renameing
*/
public cmd_rename_targ(const target, const chr, const object, const x, const y, const z, const unused, const prop)
{
	chr_getLocalStrVar(chr,CLV_CMDTEMP, tempStr);
	chr_delLocalVar(chr,CLV_CMDTEMP);
	
	//remove the "what" keyword/command word in front of the title/name/...
	new Token[1];
	str2Token(tempStr, Token, 0, tempStr,0);
	trim(tempStr);
	//printf("tempStr: %s^n", tempStr);
	
	if(isChar(object))
	{
		chr_setProperty(object,prop,_,tempStr);
		chr_update(object);
	}
	else
	{
		itm_setProperty(object, prop, _, tempStr);
		itm_refresh(object);
	}
}

static readProp(chr,&prop)
{
	//switch on first property letter, if there is ambiguity add 
	//another switch on the second letter __cmdParams[0][1]

	switch(__cmdParams[0][0])
	{
		case 'c':
		{
			if(isChar(chr))
				return INVALID;
			else prop = IP_STR_CREATOR;
		}
		case 'd':
		{
			if(isChar(chr))
				return INVALID;
			else prop = IP_STR_DESCRIPTION;
		}
		case 'h':
		{
			if(isChar(chr))
				return INVALID;
			else prop = IP_STR_NAME2;
		}
		case 'm':
		{
			if(isChar(chr))
				prop = CP_STR_DISABLEDMSG;
			else prop = IP_STR_DISABLEDMSG;
		}
		case 'n':
		{
			if(isChar(chr))
				prop = CP_STR_NAME;
			else prop = IP_STR_NAME;
		}
		case 't':
		{
			if(isChar(chr))
				prop = CP_STR_TITLE;
			else return INVALID;
		}
		default:
		{
			chr_message(chr,_,msg_commandsDef[108]);
			return INVALID;
		}
	}
	//printf("prop is: %d^n", prop);
	
	return OK;
}

/*! }@ */