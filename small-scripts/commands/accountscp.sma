/*!
\defgroup script_command_accountscp 'accountscp
\ingroup script_commands

\brief Shows the accounts control panel

\b syntax: 'accountscp [accountlist]
- accountlist: list of account numbers separated by "-" (e.g.: 2-4-67-1-45-22-3)

if the account list is not given you will be prompted to target a character.\n
With the accounts control panel you can manage accounts and characters, you can delete/block accounts
and ban/unban characters.
@{
*/

/*!
\author Fax
\fn cmd_accountscp(const chr)
\brief start function for 'accountscp command

This function is called by sources on 'accountscp command detection.\n
You can change it in commands.txt.
\since 0.82
*/
public cmd_accountscp(const chr)
{
	readCommandParams(chr);
	
	//parse accounts list if any
	if(strlen(__cmdParams[0]))
	{
		new s = set_create();
		replaceStr(__cmdParams[0],"-"," ");	//replace '-' with ' ' so the string can be tokenized
		
		//tokenize account list string and add accounts to the set
		new token[5];
		str2Token(__cmdParams[0],token,0,__cmdParams[0],0);
		while(strlen(token))
		{
			set_add(s,str2Int(token));
			str2Token(__cmdParams[0],token,0,__cmdParams[0],0);
		}
				
		accountsMenu(chr,s); //draw menu
		set_delete(s);
		return;
		
	}
	else //get a target
	{
		chr_message(chr,_,msg_commandsDef[273]);
		target_create(chr,_,_,_,"cmd_accountscp_targ");
	}	
}

/*!
\author Fax
\fn cmd_accountscp_targ(t,chr,object,x,y,z,unused,unused1)
\param chr: the character
\since 0.82
\brief handle targetting
\return nothing
*/
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

/*!
\author Fax
\fn accountsMenu(chr,s)
\param chr: the character who will see the menu
\param s: set containing the accounts to show
\since 0.82
\brief creates the accounts menu

The accounts menu is a SetListMenu with values from \a s
\return nothing
*/
static accountsMenu(chr,s)
{
	cursor_setProperty(CRP_TAB,50);
	
	createSetListMenu(0,0,15,35,s,"Accounts control panel","cmd_accountscp_drawAccount","cmd_accountscp_cback");	
		
	menu_show(chr);
}

/*!
\author Fax
\fn cmd_accountscp_drawAccount(page,line,col,i,set)
\param all: createSetListMenu() callback params
\since 0.82
\brief draws an account on the menu

\return nothing
*/
public cmd_accountscp_drawAccount(page,line,col,i,set)
{
	//get account from set and create a set with all characters in the account	
	new acc = set_get(set);	
	new chars = set_create();
	set_addAccountChars(chars,acc);
	
	new buffer[50];
	
	//print account name
	account_getName(acc,buffer);
	sprintf(buffer,"Account %d - %s^n",acc,buffer)
	menu_addText(buffer);
	
	//put "delete" button
	cursor_right(3);
	menu_addLabeledButtonFn(acc,"cmd_accountscp_deletemsgbox","delete");
	
	//put "block" button
	cursor_right(10);
	menu_addLabeledButtonFn(acc,"cmd_accountscp_blockmsgbox","block");
	cursor_newline(2);
	
	//put "new password" input field
	sprintf(buffer,"")
	cursor_right(3);
	menu_addLabeledInputField(acc*100 + 1,buffer,10,"New pwd: ");
	cursor_newline();
	
	//print last IP
	account_getLastIP(acc,buffer);
	sprintf(buffer,"last IP: %s^n^n",buffer)
	cursor_right(3);
	menu_addText(buffer);
	
	//show characters in the account
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
	
	//force a new page
	if(!set_end(set)) cursor_bottom();
}

/*!
\author Fax
\fn cmd_accountscp_cback(menu,chr,btncode)
\param menu: the current menu
\param chr: the character who used the menu
\param btncode: the pressed button return code
\since 0.82
\brief accounts menu callback, does nothing
\return nothing
*/
public cmd_accountscp_cback(menu,chr,btncode)
{
	return;
}

/*!
\author Fax
\fn cmd_accountscp_blockmsgbox(menu,chr,acc)
\param menu: the current menu
\param chr: the character
\param acc: the button return code
\since 0.82
\brief Pops up a message box asking if the account actually has to be blocked

Called as buttonFn callback by the "block" button
\return nothing
*/
public cmd_accountscp_blockmsgbox(menu,chr,acc)
{
	chr_addLocalIntVar(chr,CLV_CMDTEMP,acc);
	new msg[100];
	sprintf(msg,"Are you sure you want^nto block account %d?^nCharacters from that account^nwon't be able to log in",acc);
	messageBox(chr,"Confirm account block",msg,"cmd_accountscp_block");
}


/*!
\author Fax
\fn cmd_accountscp_deletemsgbox(menu,chr,acc)
\param menu: the current menu
\param chr: the character
\param acc: the button return code
\since 0.82
\brief Pops up a message box asking if the account actually has to be deleted

Called as buttonFn callback by the "delete" button
\return nothing
*/
public cmd_accountscp_deletemsgbox(menu,chr,acc)
{
	chr_addLocalIntVar(chr,CLV_CMDTEMP,acc);
	new msg[100];
	sprintf(msg,"Are you sure you want^nto delete account %d ?^nAccount characters ^nwill be deleted!",acc);
	messageBox(chr,"Confirm account delete",msg,"cmd_accountscp_delete");
}

/*!
\author Fax
\fn cmd_accountscp_block(menu,chr,response)
\param menu: the current menu
\param chr: the character
\param response: the button return code
\since 0.82
\brief blcks an account

Called as menu callback by the "block" message box, \a response == 2 means block
\return nothing
*/
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

/*!
\author Fax
\fn cmd_accountscp_delete(menu,chr,response)
\param menu: the current menu
\param chr: the character
\param response: the button return code
\since 0.82
\brief deletes an account

Called as menu callback by the "delete" message box, \a response == 2 means delete
\return nothing
*/
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

/*!
\author Fax
\fn cmd_accountscp_ban(menu,chr,chr2)
\param menu: the current menu
\param chr: the character
\param chr2: the button return code
\since 0.82
\brief bans a character

Called as buttonFn callback by the "ban" button
\return nothing
*/
public cmd_accountscp_ban(menu,chr,chr2)
{
	chr_ban(chr2);
	chr_message(chr,_,"Character %d banned",chr2);
}

/*!
\author Fax
\fn cmd_accountscp_unban(menu,chr,chr2)
\param menu: the current menu
\param chr: the character
\param chr2: the button return code
\since 0.82
\brief unbans a character

Called as buttonFn callback by the "unban" button
\return nothing
*/
public cmd_accountscp_unban(menu,chr,chr2)
{
	chr_unban(chr);
	chr_message(chr,_,"Character %d unbanned",chr2);
}
/*! }@ */