/*************************************************************************
 GUMP API
 *************************************************************************/
native gui_create( const guiId, const x, const y, const canMove, const canClose, const canDispose, const serial );
native gui_delete( const guiId );
native gui_show( const guiId, const chr );

native gui_addButton( const guiId, const x, const y, const gumpUp, const gumpDown, const returnCode );
native gui_addGump( const guiId, const x, const y, const gump, const hue );
native gui_addHtmlGump( const guiId, const x, const y, const width, const height, const html[], const hasBack, const canScroll )
native gui_addPage( const guiId, const page = 0 );
native gui_addPageButton( const guiId, const x, const y, const gumpUp, const gumpDown, const page );
native gui_addRadioButton( const guiId, const x, const y, const gumpOff, const gumpOn, const checked, const result );
native gui_addResizeGump( const guiId, const x, const y, const gumpId, const width, const height );
native gui_addTilePic( const guiId, const x, const y, const tile, const hue = 0 );
native gui_addTiledGump( const guiId, const x, const y, const width, const height, const gump, const hue );
native gui_addText( const guiId, const x, const y, const data[], const hue = 0 );
native gui_addCroppedText( const guiId, const x, const y, const width, const height, const data[], const hue = 0 );
native gui_addInputField( const guiId, const x, const y, const width, const height, const textId, const data[], const hue = 0 );
native gui_getInputField( const fieldId, data[] );
