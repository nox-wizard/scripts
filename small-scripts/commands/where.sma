/*!
\author Fax
\fn cmd_regioncp(const chr)
\brief opens region control panel

<B>syntax:</B> 'where

\todo make this function work when commands are done in sources, do the gump
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

