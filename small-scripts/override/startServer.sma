public __startServer()
{
	printf("^n################  Small scripts started  ###################^n^n");
	
	//Command system type message
	#if _CMD_DEBUG_
		#if _USE_SOURCE_CMDSYS_
			printf("^nSOURCE command system selected^n^n");
		#else
			printf("^nSMALL command system selected^n^n");
		#endif
	#endif
		
	//command system test
	#if _CMD_DEBUG_
	
		printf("DEBUG: Testing command system^n");
		printf("^n^tYou should see some commands added and an error message at the end^n^n")
		new result = CMD_OK;
		new name[15];
		for(new i = 0; i <  __CMD_COUNT && result == CMD_OK; i++)
		{
			sprintf(name,"testCmd%d",i);
			result = addCommand(name,5,"");
		}
		
		
		
		printf("^n^tNow you should see some commands removed and an error message at the end^n");
		printf("^tDeleted commands must be the same that were added before^n");
		result = CMD_OK;
		for(new i = 0; i < __CMD_COUNT && result == CMD_OK; i++)
		{
			sprintf(name,"testCmd%d",i);
			result = deleteCommand(name);
		}
		
		printf("^n^tEnd of command system test^n^n");
	#endif
	
	//Commands list, you can switch this off setting _CMD_SHOWLIST_ to 0
	#if _CMD_SHOWLIST_
		printf("^nAvailable commands:^n")
		for(new i = 0; i < __CMD_COUNT ; i++)
		if(strlen(__commands[i][__cmdName]))
			printf("^t%d - '%s (priv:%d)^n",i,__commands[i][__cmdName],__commands[i][__cmdPriv]);
		
		printf("^n");
	#endif
	
	resetCmdAreas(); //DO NOT REMOVE!! this initializes data for command areas
}