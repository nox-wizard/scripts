/*!
\defgroup script_command_func 'func
\ingroup script_commands
\brief executes a Small function

\b syntax: 'func [function][...]
- function: the function name
- ...: params to be passed to the function

The function prototype must be:\n
\code
	public function(chr,param1, param2, ...)
\endcode
\n
The first parameter will contain the character that used the command, remaining parameters are the
parameters specified in the command call.\n
Parameters can only be integers.
@{
*/

/*!
\author Fax
\fn cmd_func(const chr)
\param chr: the character who used the command
\since 0.82
\brief 'func command start function

This function is called by sources on 'func command detection.\n
You can change it in commands.txt.
*/
public cmd_func(const chr)
{
	readCommandParams(chr);

	new params[4], nparams = 0;

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
				}
			}
		}
	}

	switch(nparams)
	{
		case 0: callFunction1P(funcidx(__cmdParams[0]),chr);
		case 1: callFunction2P(funcidx(__cmdParams[0]),chr,params[0]);
		case 2: callFunction3P(funcidx(__cmdParams[0]),chr,params[0],params[1]);
		case 3: callFunction4P(funcidx(__cmdParams[0]),chr,params[0],params[1],params[2]);
		case 4: callFunction5P(funcidx(__cmdParams[0]),chr,params[0],params[1],params[2],params[3]);
	}
}

/*! }@ */