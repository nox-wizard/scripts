/*!
\author Fax
\fn cmd_where(const chr)
\brief prints character's position

<B>syntax:</B> 'where
Prints a message with character's location and region<BR>
\todo make this function work when commands are done in sources
<br>
*/
public cmd_where(const chr)
{
	new x,y,z,region;
	chr_getPosition(chr,x,y,z);
	region = chr_getProperty(chr,CP_REGION);
	regionname[50];
	rgn_getName(region,regionname);
	chr_message(chr,_,"You are in %s region, at %d %d %d",regionname,x,y,z);
}

