/*!
\defgroup script_command_where 'where
\ingroup script_commands

@{
*/

/*!
\author Fax
\fn cmd_where(const chr)
\brief shows character's position

<B>syntax:</B> 'where

<br>
*/
public cmd_where(const chr)
{
	new x,y,z,region;
	chr_getPosition(chr,x,y,z);
	region = chr_getProperty(chr,CP_REGION);
	new regionname[50];
	rgn_getName(region,regionname);
	chr_message(chr,_,"You are in %s region, at %d %d %d",regionname,x,y,z);
}

/*! }@ */