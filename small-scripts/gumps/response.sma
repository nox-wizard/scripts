public gui_handleResponse( const gump, const serial, const button, const chr )
{
	switch( gump )
	{
		case GUI_CHARPROP	: gui_charPropsResp( gump, serial, button, chr );
		case GUI_GUILDSTONE	: gui_guildStoneResp( gump, serial, button, chr );
		case GUI_GUILDMEMLIST	: gui_guildMemberLR( gump, serial, button, chr );
		case GUI_GUILDPROP	: gui_guildPropsResp( gump, serial, button, chr );
		case GUI_GUILDRCRLIST	: gui_guildRecruitLR( gump, serial, button, chr );
		case GUI_ITEMPROP	: gui_itemPropsResp( gump, serial, button, chr );
		case GUI_RGNLIST 	: gui_rgnListResp( gump, serial, button, chr );
		case GUI_RGNPROP	: gui_rgnPropsResp( gump, serial, button, chr );
	}
}
