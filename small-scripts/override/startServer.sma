public __startServer()
{
	printf("^n################  Small scripts started  ###################^n^n");
	
	//Command system type message
	#if _CMD_DEBUG_
		#if _USE_SOURCE_CMDSYS_
			log_message("^nSOURCE command system selected^n^n");
		#else
			log_message("^nSMALL command system selected^n^n");
		#endif
	#endif
		
	//command system test
	#if _CMD_DEBUG_
		commandSystemTest();
	#endif
	
	//Commands list, you can switch this off setting _CMD_SHOWLIST_ to 0
	#if _CMD_SHOWLIST_
		showCommandsList();
	#endif
	
	resetCmdAreas(); //DO NOT REMOVE!! this initializes data for command areas
}