/*!
\defgroup script_command_func 'func
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_func(const chr)
\brief executes a Small function

<B>syntax:</B> 'func [function][...]
<b>params:</b>
<UL>
<LI> function: the function name
<LI> ...: params to be passed to the function
Calls a PUBLIC function in the scripts passing given parameters.
<br>
*/
public cmd_func(const chr)
{
	readCommandParams(chr);

	new params[5], nparams = 0;

	//count parameters and assign them to params[]
	if(strlen(__cmdParams[1])) 
	{
		params[0] = str2Int(__cmdParams[1]); 
		nparams++;
		if(strlen(__cmdParams[2])) 
		{
			params[1] = str2Int(__cmdParams[2]); 
			nparams++;
			if(strlen(__cmdParams[3])) 
			{
				params[2] = str2Int(__cmdParams[3]); 
				nparams++;
				if(strlen(__cmdParams[4])) 
				{
					params[3] = str2Int(__cmdParams[4]); 
					nparams++;
					if(strlen(__cmdParams[5])) 
					{
						params[4] = str2Int(__cmdParams[5]); 
						nparams++;
					}
				}
			}
		}
	}

	switch(nparams)
	{
		case 0: callFunction(funcidx(__cmdParams[0]));
		case 1: callFunction1P(funcidx(__cmdParams[0]),params[0]);
		case 2: callFunction2P(funcidx(__cmdParams[0]),params[0],params[1]);
		case 3: callFunction3P(funcidx(__cmdParams[0]),params[0],params[1],params[2]);
		case 4: callFunction4P(funcidx(__cmdParams[0]),params[0],params[1],params[2],params[3]);
		case 5: callFunction5P(funcidx(__cmdParams[0]),params[0],params[1],params[2],params[3],params[4]);
	}
}

/*! }@ */