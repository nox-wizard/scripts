
public target_tweak( const socket, const target, const item )
{
	if(socket < 0) 
		return;
		
	if( isChar(target) ) {
		tweak_char( socket, target, 1 );
	}
	else if( isItem( item ) ) {
		tweak_item( socket, item, 1 );
	}
	else nprintf( socket, "Tweak work only on object" );

}

public IsNumero(const int){
	if (int > 0) return 1;
	return 0;
}

public tweak_char( const socket, const chr, const page )
{
	new menu = gui_create( 50, 50, true, true, true, "handle_tweak_char" );
	//gui_addGump( menu, 0, 0, 0x0898, 0 );
	gui_addGump( menu, 0, 0, 0x1F40, 0 );
	gui_addGump( menu, 17, 33, 0x1F41, 0 );
	gui_addGump( menu, 17, 80, 0x1F42, 0 );
	gui_addGump( menu, 17, 120, 0x1F42, 0 );
	gui_addGump( menu, 17, 180, 0x1F42, 0 );
	gui_addGump( menu, 17, 220, 0x1F42, 0 );
	gui_addGump( menu, 17, 260, 0x1F42, 0 );
	gui_addGump( menu, 17, 300, 0x1F42, 0 );
	gui_addGump( menu, 17, 340, 0x1F42, 0 );
	gui_addGump( menu, 17, 380, 0x1F42, 0 );
	gui_addGump( menu, 17, 420, 0x1F42, 0 );
	gui_addGump( menu, 17, 460, 0x1F42, 0 );
	gui_addGump( menu, 17, 500, 0x1F42, 0 );
	gui_addGump( menu, 17, 540, 0x1F43, 0 );
	
	gui_setProperty( menu, MP_BUFFER, 0, PROP_CHARACTER );
	gui_setProperty( menu, MP_BUFFER, 1, chr );
	gui_setProperty( menu, MP_BUFFER, 2, page );
	gui_setProperty( menu, MP_BUFFER, 3, 1 );
	
	gui_addButton( menu, 250, 550, 0x084A, 0x084B, 10001 );
	
	new i=1;
	new num=0;
	new Flag[128];
	new LocalV[512];

	const colorEdit = 32;
	
	gui_addText( menu, 50, 5, 0x999, "Char" );
	gui_addText( menu, 230, 5, 0x999, "LocalVar" );
	
	for (num=0;num<3000;num++) {
		if (chr_isaLocalVar(chr, num)){
			sprintf(Flag,"       Flag %d", num);
			gui_addText( menu, 30, 10+(20*i), _, Flag);
			if (IsNumero(chr_getLocalIntVar(chr,num)) == 1) {
				sprintf(LocalV, "%d" , chr_getLocalIntVar(chr,num));
				gui_addText( menu, 30, 10+(20*i), _, "Integer");
			}
			else {
				chr_getLocalStrVar(chr,num, LocalV);
				gui_addText( menu, 30, 10+(20*i), _, "String");
			}
			
			gui_addInputField( menu, 170, 10+(20*i), 125, 30, num, colorEdit, LocalV);
						
			gui_addText( menu, 270, 10+(20*i), _, "Del");
			gui_addButton( menu, 300, 10+(20*i++), 0x4B9, 0x4BA, num );
		}
	}

	gui_show( menu, getCharFromSocket(socket) );
}

public handle_tweak_char( const socket, const menu, const button )
{

	if( button==MENU_CLOSED )
	return;
		
	new chr = gui_getProperty( menu, MP_BUFFER, 1 );
		
	if( button < 49999 ) chr_delLocalVar(chr, button);


	if (button == 10001){
		new num=0;
		new Name[512];
		new value;
		for (num=0;num<3000;num++) {
			if (chr_isaLocalVar(chr, num)){
				gui_getProperty( menu, MP_UNI_TEXT, num, Name );
				trim(Name);
				nprintf(socket,"Stringa REcuperata %s",Name);
				if (isStrInt(Name)){
					value = str2Int(Name);
					chr_setLocalIntVar(chr,num,value);
				}
				else chr_setLocalStrVar(chr,num,Name);
			}
		}
	}
	
	chr_teleport( chr );
	tweak_char( socket, chr, gui_getProperty( menu, MP_BUFFER, 2 ) );
	
}

public handle_tweak_item( const socket, const menu, const button )
{
	if( button==MENU_CLOSED )
		return;
		
	new item = gui_getProperty( menu, MP_BUFFER, 1 );
		
	if( button < 49999 ) { //page button
		itm_delLocalVar(item, button);
		tweak_item( socket, item, gui_getProperty( menu, MP_BUFFER, 2 ) );
	}
	
	new num=0;
	new Name[512];
	new value;
	if (button == 10001){
		
		for (num=0;num<3000;num++) {
			if (itm_isaLocalVar(item, num)){
				gui_getProperty( menu, MP_UNI_TEXT, num, Name );
				if (isStrInt(Name)){
					value = str2Int(Name);
					itm_setLocalIntVar(item,num,value);
				}
				else itm_setLocalStrVar(item,num,Name);
			}
		}
		chr_teleport( item );
		tweak_item( socket, item, gui_getProperty( menu, MP_BUFFER, 2 ) );
	}
}

public tweak_item( const socket, const item, const page )
{
	new menu = gui_create( 50, 50, true, true, true, "handle_tweak_item" );
	//gui_addGump( menu, 0, 0, 0x0898, 0 );
	gui_addGump( menu, 0, 0, 0x1F40, 0 );
	gui_addGump( menu, 17, 33, 0x1F41, 0 );
	gui_addGump( menu, 17, 80, 0x1F42, 0 );
	gui_addGump( menu, 17, 120, 0x1F42, 0 );
	gui_addGump( menu, 17, 180, 0x1F42, 0 );
	gui_addGump( menu, 17, 220, 0x1F42, 0 );
	gui_addGump( menu, 17, 260, 0x1F42, 0 );
	gui_addGump( menu, 17, 300, 0x1F42, 0 );
	gui_addGump( menu, 17, 340, 0x1F42, 0 );
	gui_addGump( menu, 17, 380, 0x1F42, 0 );
	gui_addGump( menu, 17, 420, 0x1F42, 0 );
	gui_addGump( menu, 17, 460, 0x1F42, 0 );
	gui_addGump( menu, 17, 500, 0x1F42, 0 );
	gui_addGump( menu, 17, 540, 0x1F43, 0 );
	
	gui_setProperty( menu, MP_BUFFER, 0, PROP_ITEM );
	gui_setProperty( menu, MP_BUFFER, 1, item );
	gui_setProperty( menu, MP_BUFFER, 2, page );
	gui_setProperty( menu, MP_BUFFER, 3, 1 );
	
	gui_addButton( menu, 250, 550, 0x084A, 0x084B, 10001 );
	
	new i=1;
	new num=0;
	new Flag[128];
	new LocalV[512];
	
	const colorEdit = 32;
	
	gui_addText( menu, 50, 5, 0x999, "Item" );
	gui_addText( menu, 230, 5, 0x999, "LocalVar" );
	
	for (num=0;num<3000;num++) {
		if (itm_isaLocalVar(item, num)){
			sprintf(Flag,"       Flag %d", num);
			gui_addText( menu, 30, 10+(20*i), _, Flag);
			if (IsNumero(itm_getLocalIntVar(item,num)) == 1) {
				sprintf(LocalV, "%d" , itm_getLocalIntVar(item,num));
				gui_addText( menu, 30, 10+(20*i), _, "Integer");
			}
			else {
				itm_getLocalStrVar(item,num, LocalV);
				gui_addText( menu, 30, 10+(20*i), _, "String");
			}
			
			gui_addInputField( menu, 170, 10+(20*i), 125, 30, num, colorEdit, LocalV);

			gui_addText( menu, 270, 10+(20*i), _, "Del");
			gui_addButton( menu, 300, 10+(20*i++), 0x4B9, 0x4BA, num );
		}
	}

	gui_show( menu, getCharFromSocket(socket) );
}
