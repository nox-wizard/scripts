//#include "small-scripts/commands/add.sma"
//#include "small-scripts/commands/area.sma"
//#include "small-scripts/commands/freeze.sma"
//#include "small-scripts/commands/hiding.sma"
//#include "small-scripts/commands/invul.sma"
//#include "small-scripts/commands/kill.sma"
//#include "small-scripts/commands/make.sma"
//#include "small-scripts/commands/move.sma"
#include "small-scripts/commands/options/options.sma"
#include "small-scripts/commands/playerlist.sma"
#include "small-scripts/commands/skills/skills.sma"
#include "small-scripts/commands/stats/stats.sma"
#include "small-scripts/commands/tweak/tweak.sma"
//#include "small-scripts/commands/where.sma"
//#include "small-scripts/commands/wipe.sma"

/*!
\defgroup script_commands commands

This group of scripts contains all the ingame commands scripts.<br>
The commandlevel management is done internally, in the sources, but you can 
define, modify all the commands you want by editing the existing scripts.<br>

\section commandsplayerinterface Player interface
Players can use ingame commands, that is, they can send commands to the server to make various things.
Not all commands are available to all players, every command needs a certain authorization to be used, this authorization
is the "command level" or "privlevel".<br>
The privlevel is a number, this number defines if a command is usable by a player or not.<br>
To use a command the player has to write:<br>
'[commandname] <br>
for example:<br>
'wipe 'kill 'invul <br>
are all commands.<br>
<br>
Usually a command takes some parameters wich specify how the command should work:<br>
'invul on<br>
'kill target<br>
are examples.

\section usingcommands Using commands
Using commands is easy, simpy type the command (with his parameters) and the follow the instructions that
appear as messages in the bottom left corner of the screen.<br>
Usually a command requires to target a character or item, in that case the target pointer will appear
with a prompt saying what you should target.
When a command requires parameters, there always some default values for the most used values.<br>
When a parameter has a default value tou can ommit it in the command call, and the default will be assumed.<br>
If you want to specify a parameter, you have to specify all the preceding parameters, or you will get errors.<br>
In the commands documentation, it is always written the dafault value for every parameter.

\section commandareas Command areas
A player who can use the 'area command, can set "command area".<br>
This is needed sometimes when you have to aplly a command to a large number of items/characters
and it would be boring to write the command many times.<br>
See the \ref script_command_area for more details.

\section customizability Customizability
You can define all commands you want, modify the privlevels, modify/erase existing commands, in other words,
you can do everything you want with commands!<br>
To edit an existing command simply open the corresponding script (has the same name as the command, in the small-scripts\commands folder)
and modify it, the commands' behaviour is completely written in small, so you full control over it.<br>

*/