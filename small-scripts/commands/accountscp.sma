/*!
\defgroup script_command_accountscp 'accountscp
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_accountscp(const chr)
\brief shows account control panel

<B>syntax:</B> 'accountscp [accountlist]
<UL>
	<LI> accountlist: list of account numbers separated by "-" (e.g.: 2-4-67-1-45-22-3)
</UL>

if the account list is not given you will be prompted to target a character.
*/
public cmd_accountscp(const chr)
{
	readCommandParams(chr);
	
	if(strlen(__cmdParams[0]))
	{
		new s = set_create();
		replaceStr(__cmdParams[0],"-"," ");
		
		//read accounts list
		new token[5];
		str2Token(__cmdParams[0],token,0,__cmdParams[0],0);
		while(strlen(token))
		{
			set_add(s,str2Int(token));
			str2Token(__cmdParams[0],token,0,__cmdParams[0],0);
		}
		
		accountsMenu(chr,s);
		set_delete(s);
		return;
		
	}
	else 
	{
		chr_message(chr,_,msg_commandsDef[273]);
		target_create(chr,_,_,_,"cmd_accountscp_targ");
	}	
}

public cmd_accountscp_targ(t,chr,object,x,y,z,unused,unused1)
{
	if(isChar(object) || !chr_isNpc(object))
	{
		new s = set_create();
		set_add(s,chr_getProperty(object,CP_ACCOUNT));
		accountsMenu(chr,s);
		set_delete(s);
		return;
	}
	
	chr_message(chr,_,msg_commandsDef[23]);
}

static accountsMenu(chr,s)
{
	cursor_setProperty(CRP_TAB,50);
	
	createSetListMenu(0,0,15,35,s,"Accounts control panel","cmd_accountscp_drawAccount","cmd_accountscp_cback");	
		
	menu_show(chr);
}

public cmd_accountscp_drawAccount(page,line,col,i,set)
{
		
	new acc = set_get(set);	
	new chars = set_create();
	set_addAccountChars(chars,acc);
	
	new buffer[50];
	
	account_getName(acc,buffer);
	sprintf(buffer,"Account %d - %s^n",acc,buffer)
	menu_addText(buffer);
	
	cursor_right(3);
	menu_addLabeledButtonFn(acc,"cmd_accountscp_deletemsgbox","delete");
	
	cursor_right(10);
	menu_addLabeledButtonFn(acc,"cmd_accountscp_blockmsgbox","block");
	cursor_newline(2);
	
	//account_getPW(acc,buffer);
	sprintf(buffer,"")
	cursor_right(3);
	menu_addLabeledInputField(acc*100 + 1,buffer,10,"New pwd: ");
	cursor_newline();
	
	
	account_getLastIP(acc,buffer);
	sprintf(buffer,"last IP: %s^n^n",buffer)
	cursor_right(3);
	menu_addText(buffer);
	
	if(set_size(chars))
	{
		menu_addText("Characters:^n");
		
		new chr,name[30];
		for(set_rewind(chars); !set_end(chars); )
		{
			chr = set_getChar(chars);
			chr_getProperty(chr,CP_STR_NAME,0,name);
			sprintf(buffer,"%s (%d)",name,chr);
			
			cursor_right(3);
			menu_addText(buffer);
			
			cursor_right(strlen(buffer) + 4);
			menu_addLabeledButtonFn(chr,"cmd_accountscp_ban","ban");
			
			cursor_right(7);
			menu_addLabeledButtonFn(chr,"cmd_accountscp_unban","unban");
			
			cursor_newline();
		}
	}
	
	set_delete(chars);
	
	//change page
	if(!set_end(set)) cursor_bottom();
}

public cmd_accountscp_cback(menu,chr,btncode)
{
	return;
}

public cmd_accountscp_blockmsgbox(menu,chr,acc)
{
	chr_addLocalIntVar(chr,CLV_CMDTEMP,acc);
	new msg[100];
	sprintf(msg,"Are you sure you want^nto block account %d?^nCharacters from that account^nwon't be able to log in",acc);
	messageBox(chr,"Confirm account block",msg,"cmd_accountscp_block");
}

public cmd_accountscp_deletemsgbox(menu,chr,acc)
{
	chr_addLocalIntVar(chr,CLV_CMDTEMP,acc);
	new msg[100];
	sprintf(msg,"Are you sure you want^nto delete account %d ?^nAccount characters ^nwill be deleted!",acc);
	messageBox(chr,"Confirm account delete",msg,"cmd_accountscp_delete");
}

public cmd_accountscp_block(menu,chr,response)
{
	new acc = chr_getLocalIntVar(chr,CLV_CMDTEMP);
	chr_delLocalVar(chr,CLV_CMDTEMP);
	
	if(response == 2)
	{
		account_block(acc);
		chr_message(chr,_,"Account %d blocked",acc);
	}
}

public cmd_accountscp_delete(menu,chr,response)
{
	new acc = chr_getLocalIntVar(chr,CLV_CMDTEMP);
	chr_delLocalVar(chr,CLV_CMDTEMP);
	
	if(response == 2)
	{
		account_delete(acc);
		chr_message(chr,_,"Account %d deleted",acc);
	}
}

public cmd_accountscp_ban(menu,chr,chr2)
{
	chr_ban(chr2);
	chr_message(chr,_,"Character %d banned",chr2);
}


public cmd_accountscp_unban(menu,chr,chr2)
{
	chr_unban(chr);
	chr_message(chr,_,"Character %d unbanned",chr2);
}
/*! }@ */