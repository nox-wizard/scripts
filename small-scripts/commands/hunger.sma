/*!
\defgroup script_command_hunger 'hunger
\ingroup script_commands

@{
*/

/*!
\author Horian(const chr)
\fn cmd_hunger
\brief gives ingame info about hunger and thirst status

<B>syntax:<B> 'hunger
*/
public cmd_hunger(const c)
{
	new hunger = chr_getLocalIntVar(c, 1002);//Hungervalue
	new thirst = chr_getLocalIntVar(c, 1003);//thirst value

	switch(hunger)
	{
		case 0..1: chr_message( c, _, "You must eat something immediatelly or you will die in 1 minute!");
		case 2..11: chr_message( c, _, "You must eat something very very fast or you will die from hunger!");
		case 12..21: chr_message( c, _, "You are extremly hungry!");
		case 22..31: chr_message( c, _, "You are very hungry and start feeling dizzy!");
		case 32..41: chr_message( c, _, "You are really hungry and your stomache growls loudly!");
		case 42..51: chr_message( c, _, "You stomach starts growling by hunger!");
		case 52..61: chr_message( c, _, "You are bit hungry.");
		case 62..71: chr_message( c, _, "You could have something to eat.");
		case 72..81: chr_message( c, _, "You feel satisfied.");
		case 82..91: chr_message( c, _, "You are well fed.");
		case 92..100: chr_message( c, _, "You are absolutly stuffed.");
		default: 
		{
			chr_message( c, _, "You die from starving too long!");
		}
	}
	switch(thirst)
	{
		case 0..1: chr_message( c, _, "And you must drink something immediatelly or you will die in 1 minute!^n");
		case 2..11: chr_message( c, _, "And you must drink something very very fast or you will die from thirst!^n");
		case 12..21: chr_message( c, _, "And you are extremly thirsty!^n");
		case 22..31: chr_message( c, _, "And you are very thirsty and start feeling dizzy!^n");
		case 32..41: chr_message( c, _, "And you are really hungry and your tongue sticks in your mouth!^n");
		case 42..51: chr_message( c, _, "And your tongue starts becoming sticky by thirst!^n");
		case 52..61: chr_message( c, _, "And you are bit thirsty.^n");
		case 62..71: chr_message( c, _, "And you could have something to drink.^n");
		case 72..81: chr_message( c, _, "And you don't need to drink anything.^n");
		case 82..91: chr_message( c, _, "And you feel absolutely no thirst.^n");
		case 92..100: chr_message( c, _, "And your belly is filled with liquid.^n");
		default: 
		{
			chr_message( c, _, "And you die from being thirsty too long!^n");
		}
	}
}

/*! }@ */