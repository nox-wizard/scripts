static const rowSpacing	= 2;
static const rowHeight	= 25;
static rowDistance	= 0;
static rowY		= 0;
static const colSpacing	= 2;
static const col1Len	= 170;
static const col2Len	= 170;
static const col1X	= 10;
static col2X		= 0;
static col1XTxt		= 0;
static col2XTxt		= 0;
static const colBackGump= 0x52;
static lastPage		= 12;
static const rowsPerPage= 12;
static currentPageRow	= 0;
static stringMode	= 0;
//
// Field identifiers
//
static const propAmount		= 1;
static const propAmount2	= 2;
static const propAttack		= 3;
static const propAnimation	= 4;
static const propCarve		= 5;
static const propColor		= 6;
static const propContainedIn	= 7;
static const propContainedInOld	= 8;
static const propCreator	= 9;
static const propDamageLow	= 10;
static const propDamageHigh	= 11;
static const propDecay		= 12;
static const propDecayTime	= 13;
static const propDefence	= 14;
static const propDescription	= 15;
static const propDexBonus	= 16;
static const propDexRequired	= 17;
static const propDirection	= 18;
static const propDisabled	= 19;
static const propDisabledMsg	= 20;
static const propDisabledTime	= 21;
static const propDoorDir	= 22;
static const propDoorOpen	= 23;
static const propDyeable	= 24;
static const propGateNumber	= 25;
static const propGateTime	= 26;
static const propGlow		= 27;
static const propGlowFx		= 28;
static const propGood		= 29;
static const propHitPoints	= 30;
static const propHitPointsMax	= 31;
/*
 * Read only
 *
static const propIncognito	= 32;
 */
static const propIntBonus	= 33;
static const propIntRequired	= 34;
static const propItemHand	= 35;
static const propLayerCurrent	= 36;
static const propLayerOld	= 37;
static const propLocation	= 38;
static const propLocationOld	= 39;
static const propLocationMore	= 40;
static const propMadeWith	= 41;
static const propMagic		= 42;
static const propMore1		= 43;
static const propMore2		= 44;
static const propMore3		= 45;
static const propMore4		= 46;
static const propMoreB1		= 47;
static const propMoreB2		= 48;
static const propMoreB3		= 49;
static const propMoreB4		= 50;
static const propMultiSerial	= 51;
/*
 * Not implemented yet
 *
static const propMurderer	= 52;
 */
static const propMurderTime	= 53;
static const propNameCurrent	= 54;
static const propNameReal	= 55;
static const propNewbie		= 56;
/*
 * Not implemented yet
 *
static const propOffSpell	= 57;
 */
static const propOnDamage	= 58;
static const propOnEquip	= 59;
static const propOnUnequip	= 60;
static const propOnClick	= 61;
static const propOnDoubleClick	= 62;
static const propOnPutInpack	= 63;
static const propOnDropInLand	= 64;
static const propOnCheckCanUse	= 65;
static const propOnTransfer	= 66;
static const propOnStolen	= 67;
static const propOnPoisoned	= 68;
static const propOnDecay	= 69;
static const propOnRemoveTrap	= 70;
static const propOnLockPick	= 71;
static const propOnWalkOver	= 72;
static const propOwnerSerial	= 73;
static const propPileable	= 74;
static const propPoisoned	= 75;
static const propRank		= 76;
static const propRestock	= 77;
static const propScriptId	= 78;
static const propSecure		= 79;
static const propSerial		= 80;
static const propSkillRequired	= 81;
static const propSmelt		= 82;
static const propSpawnRegion	= 83;
static const propSpawnSerial	= 84;
static const propSpeed		= 85;
static const propStrBonus	= 86;
static const propStrRequired	= 87;
/*
 * Read only
 *
static const propTimeUnused	= 88;
static const propTimeUsedLast	= 89;
 */
static const propTrigger	= 90;
static const propTriggerUses	= 91;
static const propTriggerType	= 92;
static const propType		= 93;
static const propType2		= 94;
static const propValue		= 95;
static const propVisible	= 96;
static const propWeight		= 97;
static const propWipe		= 98;
static const propVisualId	= 99;
static const propDispellable	= 100;
static const propRndValueRate	= 101;
static const propMoreX		= 102;
static const propMoreY		= 103;
static const propMoreZ		= 104;

static const propLocalVariables	= 200;
//
// Button Identifiers
//
static const buttonCancel	= 0;

public gui_itemProps( const clickedItem, const showToWhom, const edit )
{
	itemPropsPage( clickedItem, showToWhom, edit, 1 );
}

public gui_itemPropsResp( const gump, const serial, const button, const pc )
{
	if( button != buttonCancel )
	{
		new page;
		new edit;
		new updateItem = 0;
		itemPropsRespInit( button, edit, page );
		if( page != button )
		{
			itemPropsRespExit( updateItem, serial, pc, page, edit );
			return;
		}
		stringMode = getStringMode();
		//
		// switch to packed string mode
		//
		if( !stringMode )
			setStringMode( 1 );

		new newString[64];	// packed string arrays for max 256 chars including trailing '/0'
		new oldString[64];
		new newNumeric;
		new oldNumeric;
		new newStringLength;
		if( page == 1 )
		{
			//
			// process changes to: Amount
			// --------------------------
			//
			gui_getInputField( propAmount, newString );
			oldNumeric = itm_getProperty( serial, IP_AMOUNT, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_AMOUNT, _, newNumeric );
			//
			// process changes to: Amount2
			// ---------------------------
			//
			gui_getInputField( propAmount2, newString );
			oldNumeric = itm_getProperty( serial, IP_AMOUNT2, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_AMOUNT2, _, newNumeric );
			//
			// process changes to: Animation Id
			// --------------------------------
			//
			gui_getInputField( propAnimation, newString );
			oldNumeric = itm_getProperty( serial, IP_ANIMID, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				itm_setProperty( serial, IP_ANIMID, _, newNumeric );
				updateItem = 1;
			}
			//
			// process changes to: Attack
			// --------------------------
			//
			gui_getInputField( propAttack, newString );
			oldNumeric = itm_getProperty( serial, IP_ATT, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_ATT, _, newNumeric );
			//
			// process changes to: Carve
			// -------------------------
			//
			gui_getInputField( propCarve, newString );
			oldNumeric = itm_getProperty( serial, IP_CARVE, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_CARVE, _, newNumeric );
			//
			// process changes to: Color
			// -------------------------
			//
			gui_getInputField( propColor, newString );
			oldNumeric = itm_getDualByteProperty( serial, IP_COLOR );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				itm_setDualByteProperty( serial, IP_COLOR, newNumeric );
				updateItem = 1;
			}
			//
			// process changes to: Container serial
			// ------------------------------------
			//
			gui_getInputField( propContainedIn, newString );
			oldNumeric = itm_getProperty( serial, IP_CONTAINERSERIAL, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_CONTAINERSERIAL, _, newNumeric );
			//
			// process changes to: Container serial old
			// ----------------------------------------
			//
			gui_getInputField( propContainedInOld, newString );
			oldNumeric = itm_getProperty( serial, IP_OLDCONTAINERSERIAL, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_OLDCONTAINERSERIAL, _, newNumeric );
			//
			// Finish
			//
			itemPropsRespExit( updateItem, serial, pc, page, edit );
			return;
		}
		if( page == 2 )
		{
			//
			// process changes to: Name creator
			// --------------------------------
			//
			gui_getInputField( propCreator, newString );
			trim( newString );
			itm_getProperty( serial, IP_STR_CREATOR, _, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( newString ) > 49 )
					newString{49} = 0;
				itm_setProperty( serial, IP_STR_CREATOR, _, newString );
			}
			//
			// process changes to: Damage low
			// ------------------------------
			//
			gui_getInputField( propDamageLow, newString );
			oldNumeric = itm_getProperty( serial, IP_LODAMAGE, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_LODAMAGE, _, newNumeric );
			//
			// process changes to: Damage high
			// -------------------------------
			//
			gui_getInputField( propDamageHigh, newString );
			oldNumeric = itm_getProperty( serial, IP_HIDAMAGE, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_HIDAMAGE, _, newNumeric );
			//
			// process changes to: Decay
			// -------------------------
			//
			gui_getInputField( propDecay, newString );
			oldNumeric = (itm_getProperty( serial, IP_PRIV, _)&0x01 ? 1 : 0);
			newNumeric = prop2Boolean( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				if( newNumeric )
					itm_setProperty( serial, IP_PRIV, _, itm_getProperty( serial, IP_PRIV, _) | 0x01 );
				else
					itm_setProperty( serial, IP_PRIV, _, itm_getProperty( serial, IP_PRIV, _) & ~0x01 );
			}
			//
			// process changes to: Decay Time
			// ------------------------------
			//
			gui_getInputField( propDecayTime, newString );
			oldNumeric = itm_getProperty( serial, IP_DECAYTIME, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_DECAYTIME, _, newNumeric );
			//
			// process changes to: Defence
			// ---------------------------
			//
			gui_getInputField( propDefence, newString );
			oldNumeric = itm_getProperty( serial, IP_DEF, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_DEF, _, newNumeric );
			//
			// process changes to: Description
			// -------------------------------
			//
			gui_getInputField( propDescription, newString );
			trim( newString );
			itm_getProperty( serial, IP_STR_DESCRIPTION, _, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( newString ) > 99 )
					newString{99} = 0;
				itm_setProperty( serial, IP_STR_DESCRIPTION, _, newString );
			}
			//
			// process changes to: Dexterity Bonus
			// -----------------------------------
			//
			gui_getInputField( propDexBonus, newString );
			oldNumeric = itm_getProperty( serial, IP_DEXBONUS, _ );
			newNumeric = prop2Signed( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_DEXBONUS, _, newNumeric );
			//
			// process changes to: Dexterity Required
			// --------------------------------------
			//
			gui_getInputField( propDexRequired, newString );
			oldNumeric = itm_getProperty( serial, IP_DEXREQUIRED, _ );
			newNumeric = prop2Signed( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_DEXREQUIRED, _, newNumeric );
			//
			// process changes to: Direction
			// -----------------------------
			//
			gui_getInputField( propDirection, newString );
			newStringLength = strlen( newString );
			if( newStringLength )
			{
				trim( newString );
				newNumeric = (isStrUnsignedInt(newString) ? str2UnsignedInt(newString) : (isStrHex(newString) ? str2Hex(newString) : -1 ));
				oldNumeric = itm_getProperty( serial, IP_DIR, _ );
				if( newNumeric == -1 )
				{
					//
					// check for direction strings
					//
					str2lower( newString );
					if( !strcmp(newString, "n") || !strcmp(newString, "north") )
						newNumeric = 0;
					else
						if( !strcmp(newString, "ne") || !strcmp(newString, "northeast") || !strcmp(newString, "north-east") || !strcmp(newString, "north east"))
							newNumeric = 1;
						else
							if( !strcmp(newString, "e") || !strcmp(newString, "east") )
								newNumeric = 2;
							else
								if( !strcmp(newString, "se") || !strcmp(newString, "southeast") ||  !strcmp(newString, "south-east") || !strcmp(newString, "south east"))
									newNumeric = 3;
								else
									if( !strcmp(newString, "s") || !strcmp(newString, "south") )
										newNumeric = 4;
									else
										if( !strcmp(newString, "sw") || !strcmp(newString, "southwest") || !strcmp(newString, "south-west") || !strcmp(newString, "south west") )
											newNumeric = 5;
										else
											if( !strcmp(newString, "w") || !strcmp(newString, "west") )
												newNumeric = 6;
											else
												if( !strcmp(newString, "nw") || !strcmp(newString, "northwest") || !strcmp(newString, "north-west") || !strcmp(newString, "north west") )
													newNumeric = 7;
												else
													newNumeric = oldNumeric;
				}
				if( newNumeric >= 0 && newNumeric <= 7 && newNumeric != oldNumeric )
				{
					itm_setProperty( serial, IP_DIR, _, newNumeric );
					updateItem = 1;
				}
			}
			//
			// Finish
			//
			itemPropsRespExit( updateItem, serial, pc, page, edit );
			return;
		}
		if( page == 3 )
		{
			//
			// process changes to: Disabled Message
			// ------------------------------------
			//
			gui_getInputField( propDisabledMsg, newString );
			trim( newString );
			itm_getProperty( serial, IP_STR_DISABLEDMSG, _, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( newString ) > 127 )
					newString{127} = 0;
				itm_setProperty( serial, IP_STR_DISABLEDMSG, _, newString );
			}
			//
			// process changes to: Disabled Time
			// ---------------------------------
			//
			gui_getInputField( propDisabledTime, newString );
			oldNumeric = itm_getProperty( serial, IP_DISABLED, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_DISABLED, _, newNumeric );
			//
			// process changes to: Dispellable
			// -------------------------------
			//
			gui_getInputField( propDispellable, newString );
			oldNumeric = (itm_getProperty( serial, IP_PRIV, _) & 0x04 ? 1 : 0);
			newNumeric = prop2Boolean( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				if( newNumeric )
					itm_setProperty( serial, IP_PRIV, _, itm_getProperty( serial, IP_PRIV, _) | 0x04 );
				else
					itm_setProperty( serial, IP_PRIV, _, itm_getProperty( serial, IP_PRIV, _) & ~0x04 );
			}
			//
			// process changes to: Door dir
			// ----------------------------
			//
			gui_getInputField( propDoorDir, newString );
			oldNumeric = itm_getProperty( serial, IP_DOORDIR, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_DOORDIR, _, newNumeric );
			//
			// process changes to: Door open
			// -----------------------------
			//
			gui_getInputField( propDoorOpen, newString );
			oldNumeric = itm_getProperty( serial, IP_DOOROPEN, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_DOOROPEN, _, newNumeric );
			//
			// process changes to: Dyeable
			// ---------------------------
			//
			gui_getInputField( propDyeable, newString );
			oldNumeric = itm_getProperty( serial, IP_DYE, _);
			newNumeric = prop2Boolean( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_DYE, _, newNumeric );
			//
			// process changes to: Event On Damage
			// ----------------------------------
			//
			gui_getInputField( propOnDamage, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONDAMAGE, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONDAMAGE );
				itm_setEventHandler( serial, EVENT_ITM_ONDAMAGE, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Equip
			// ----------------------------------
			//
			gui_getInputField( propOnEquip, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONEQUIP, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONEQUIP );
				itm_setEventHandler( serial, EVENT_ITM_ONEQUIP, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On UnEquip
			// ----------------------------------
			//
			gui_getInputField( propOnUnequip, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONUNEQUIP, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONUNEQUIP );
				itm_setEventHandler( serial, EVENT_ITM_ONUNEQUIP, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Click
			// ----------------------------------
			//
			gui_getInputField( propOnClick, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONCLICK, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONCLICK );
				itm_setEventHandler( serial, EVENT_ITM_ONCLICK, EVENTTYPE_STATIC, newString );
			}
			//
			// Finish
			//
			itemPropsRespExit( updateItem, serial, pc, page, edit );
			return;
		}
		if( page == 4 )
		{
			//
			// process changes to: Event On Double Click
			// -----------------------------------------
			//
			gui_getInputField( propOnDoubleClick, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONDBLCLICK, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONDBLCLICK );
				itm_setEventHandler( serial, EVENT_ITM_ONDBLCLICK, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Put In Backpack
			// --------------------------------------------
			//
			gui_getInputField( propOnPutInpack, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONPUTINBACKPACK, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONPUTINBACKPACK );
				itm_setEventHandler( serial, EVENT_ITM_ONPUTINBACKPACK, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Drop In Land
			// -----------------------------------------
			//
			gui_getInputField( propOnDropInLand, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONDROPINLAND, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONDROPINLAND );
				itm_setEventHandler( serial, EVENT_ITM_ONDROPINLAND, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Check Any Use
			// ------------------------------------------
			//
			gui_getInputField( propOnCheckCanUse, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONCHECKCANUSE, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONCHECKCANUSE );
				itm_setEventHandler( serial, EVENT_ITM_ONCHECKCANUSE, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Transfer
			// -------------------------------------
			//
			gui_getInputField( propOnTransfer, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONTRANSFER, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONTRANSFER );
				itm_setEventHandler( serial, EVENT_ITM_ONTRANSFER, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Stolen
			// -----------------------------------
			//
			gui_getInputField( propOnStolen, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONSTOLEN, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONSTOLEN );
				itm_setEventHandler( serial, EVENT_ITM_ONSTOLEN, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Poisoned
			// -------------------------------------
			//
			gui_getInputField( propOnPoisoned, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONPOISONED, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONPOISONED );
				itm_setEventHandler( serial, EVENT_ITM_ONPOISONED, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Decay
			// ----------------------------------
			//
			gui_getInputField( propOnDecay, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONDECAY, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONDECAY );
				itm_setEventHandler( serial, EVENT_ITM_ONDECAY, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Remove Trap
			// ----------------------------------------
			//
			gui_getInputField( propOnRemoveTrap, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONREMOVETRAP, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONREMOVETRAP );
				itm_setEventHandler( serial, EVENT_ITM_ONREMOVETRAP, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Lockpick
			// -----------------------------------------
			//
			gui_getInputField( propOnLockPick, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONLOCKPICK, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONLOCKPICK );
				itm_setEventHandler( serial, EVENT_ITM_ONLOCKPICK, EVENTTYPE_STATIC, newString );
			}
			//
			// Finish
			//
			itemPropsRespExit( updateItem, serial, pc, page, edit );
			return;
		}
		if( page == 5 )
		{
			//
			// process changes to: Event On Walkover
			// -------------------------------------
			//
			gui_getInputField( propOnWalkOver, newString );
			trim( newString );
			itm_getEventHandler( serial, EVENT_ITM_ONWALKOVER, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					itm_delEventHandler( serial, EVENT_ITM_ONWALKOVER );
				itm_setEventHandler( serial, EVENT_ITM_ONWALKOVER, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Gatenumber
			// -----------------------------------
			//
			gui_getInputField( propGateNumber, newString );
			oldNumeric = itm_getProperty( serial, IP_GATENUMBER, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_GATENUMBER, _, newNumeric );
			//
			// process changes to: Gatetime
			// ----------------------------
			//
			gui_getInputField( propGateTime, newString );
			oldNumeric = itm_getProperty( serial, IP_GATETIME, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_GATETIME, _, newNumeric );
			//
			// process changes to: Glow
			// ------------------------
			//
			gui_getInputField( propGlow, newString );
			oldNumeric = itm_getProperty( serial, IP_GLOW, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_GLOW, _, newNumeric );
			//
			// process changes to: GlowFx
			// ------------------------
			//
			gui_getInputField( propGlowFx, newString );
			oldNumeric = itm_getProperty( serial, IP_GLOWFX, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_GLOWFX, _, newNumeric );
			//
			// process changes to: Hit points
			// ------------------------------
			//
			gui_getInputField( propHitPoints, newString );
			oldNumeric = itm_getProperty( serial, IP_HP, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_HP, _, newNumeric );
			//
			// process changes to: Hit points maximum
			// --------------------------------------
			//
			gui_getInputField( propHitPointsMax, newString );
			oldNumeric = itm_getProperty( serial, IP_MAXHP, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MAXHP, _, newNumeric );
			//
			// process changes to: Intelligence bonus
			// --------------------------------------
			//
			gui_getInputField( propIntBonus, newString );
			oldNumeric = itm_getProperty( serial, IP_INTBONUS, _ );
			newNumeric = prop2Signed( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_INTBONUS, _, newNumeric );
			//
			// Finish
			//
			itemPropsRespExit( updateItem, serial, pc, page, edit );
			return;
		}
		if( page == 6 )
		{
			//
			// process changes to: Intelligence required
			// -----------------------------------------
			//
			gui_getInputField( propIntRequired, newString );
			oldNumeric = itm_getProperty( serial, IP_INTREQUIRED, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_INTREQUIRED, _, newNumeric );
			//
			// process changes to: Item hand
			// -----------------------------
			//
			// TODO validation
			//
			gui_getInputField( propItemHand, newString );
			oldNumeric = itm_getProperty( serial, IP_ITEMHAND, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_ITEMHAND, _, newNumeric );
			//
			// process changes to: Layer current
			// ---------------------------------
			//
			gui_getInputField( propLayerCurrent, newString );
			oldNumeric = itm_getProperty( serial, IP_LAYER, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_LAYER, _, newNumeric );
			//
			// process changes to: Layer old
			// -----------------------------
			//
			gui_getInputField( propLayerOld, newString );
			oldNumeric = itm_getProperty( serial, IP_OLDLAYER, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_OLDLAYER, _, newNumeric );
			//
			// process changes to: Location
			// ----------------------------
			//
			// TO DO: check for valid coordinates
			//
			gui_getInputField( propLocation, newString );
			newStringLength = strlen( newString );
			if( newStringLength )
			{
				trim( newString );
				new token[64];
				new x = -9999;
				new y = -9999;
				new z = -9999;
				str2Token( newString, token, 1, oldString, 1 );
				if( isStrUnsignedInt( token ) )
				{
					x = str2UnsignedInt( token );
					str2Token( oldString, token, 1, newString, 1 );
					if( isStrUnsignedInt( token ) )
					{
						y = str2UnsignedInt( token );
						str2Token( newString, token, 1, oldString, 1 );
						if( isStrInt( token ) )
							z = str2Int( token );
					}
				}
				if( x != -9999 && y != -9999 && z != -9999 )
				{
					itm_setProperty( serial, IP_POSITION, IP2_X, x );
					itm_setProperty( serial, IP_POSITION, IP2_Y, y );
					itm_setProperty( serial, IP_POSITION, IP2_Z, z );
					updateItem = 1;
				}
			}
			//
			// process changes to: Location old
			// --------------------------------
			//
			// TO DO: check for valid coordinates
			//
			gui_getInputField( propLocationOld, newString );
			newStringLength = strlen( newString );
			if( newStringLength )
			{
				trim( newString );
				new token[64];
				new x = -9999;
				new y = -9999;
				new z = -9999;
				str2Token( newString, token, 1, oldString, 1 );
				if( isStrUnsignedInt( token ) )
				{
					x = str2UnsignedInt( token );
					str2Token( oldString, token, 1, newString, 1 );
					if( isStrUnsignedInt( token ) )
					{
						y = str2UnsignedInt( token );
						str2Token( newString, token, 1, oldString, 1 );
						if( isStrInt( token ) )
							z = str2Int( token );
					}
				}
				if( x != -9999 && y != -9999 && z != -9999 )
				{
					itm_setProperty( serial, IP_OLDPOSITION, IP2_X, x );
					itm_setProperty( serial, IP_OLDPOSITION, IP2_Y, y );
					itm_setProperty( serial, IP_OLDPOSITION, IP2_Z, z );
				}
			}
			//
			// process changes to: Location more
			// ---------------------------------
			//
			// TO DO: check for valid coordinates
			//
			if ( itm_getProperty( serial, IP_TYPE, _) != 61 && itm_getProperty( serial, IP_TYPE, _) != 62 )
			{
				gui_getInputField( propLocationOld, newString );
				newStringLength = strlen( newString );
				if( newStringLength )
				{
					trim( newString );
					new token[64];
					new x = -9999;
					new y = -9999;
					new z = -9999;
					str2Token( newString, token, 1, oldString, 1 );
					if( isStrUnsignedInt( token ) )
					{
						x = str2UnsignedInt( token );
						str2Token( oldString, token, 1, newString, 1 );
						if( isStrUnsignedInt( token ) )
						{
							y = str2UnsignedInt( token );
							str2Token( newString, token, 1, oldString, 1 );
							if( isStrInt( token ) )
								z = str2Int( token );
						}
					}
					if( x != -9999 && y != -9999 && z != -9999 )
					{
						itm_setProperty( serial, IP_MOREPOSITION, IP2_X, x );
						itm_setProperty( serial, IP_MOREPOSITION, IP2_Y, y );
						itm_setProperty( serial, IP_MOREPOSITION, IP2_Z, z );
					}
				}
			}
			//
			// process changes to: Made with
			// -----------------------------
			//
			gui_getInputField( propMadeWith, newString );
			oldNumeric = itm_getProperty( serial, IP_MADEWITH, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MADEWITH, _, newNumeric );
			//
			// process changes to: Magic
			// -------------------------
			//
			gui_getInputField( propMagic, newString );
			oldNumeric = itm_getProperty( serial, IP_MAGIC, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MAGIC, _, newNumeric );
			//
			// process changes to: More 1
			// --------------------------
			//
			gui_getInputField( propMore1, newString );
			oldNumeric = itm_getProperty( serial, IP_MORE, 1 );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MORE, 1, newNumeric );
			//
			// Finish
			//
			itemPropsRespExit( updateItem, serial, pc, page, edit );
			return;
		}
		if( page == 7 )
		{
			//
			// process changes to: More 2
			// --------------------------
			//
			gui_getInputField( propMore2, newString );
			oldNumeric = itm_getProperty( serial, IP_MORE, 2 );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MORE, 2, newNumeric );
			//
			// process changes to: More 3
			// --------------------------
			//
			gui_getInputField( propMore3, newString );
			oldNumeric = itm_getProperty( serial, IP_MORE, 3 );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MORE, 3, newNumeric );
			//
			// process changes to: More 4
			// --------------------------
			//
			gui_getInputField( propMore4, newString );
			oldNumeric = itm_getProperty( serial, IP_MORE, 4 );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MORE, 4, newNumeric );
			//
			// process changes to: MoreB 1
			// ---------------------------
			//
			gui_getInputField( propMoreB1, newString );
			oldNumeric = itm_getProperty( serial, IP_MOREB, 1 );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MOREB, 1, newNumeric );
			//
			// process changes to: MoreB 2
			// ---------------------------
			//
			gui_getInputField( propMoreB2, newString );
			oldNumeric = itm_getProperty( serial, IP_MOREB, 2 );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MOREB, 2, newNumeric );
			//
			// process changes to: MoreB 3
			// ---------------------------
			//
			gui_getInputField( propMoreB3, newString );
			oldNumeric = itm_getProperty( serial, IP_MOREB, 3 );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MOREB, 3, newNumeric );
			//
			// process changes to: MoreB 4
			// ---------------------------
			//
			gui_getInputField( propMore4, newString );
			oldNumeric = itm_getProperty( serial, IP_MOREB, 4 );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MOREB, 4, newNumeric );
			//
			// process changes to: MoreX
			// -------------------------
			//
			gui_getInputField( propMoreX, newString );
			oldNumeric = itm_getProperty( serial, IP_MOREPOSITION, IP2_X );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MOREPOSITION, IP2_X, newNumeric );
			//
			// process changes to: MoreY
			// -------------------------
			//
			gui_getInputField( propMoreY, newString );
			oldNumeric = itm_getProperty( serial, IP_MOREPOSITION, IP2_Y );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MOREPOSITION, IP2_Y, newNumeric );
			//
			// process changes to: MoreZ
			// -------------------------
			//
			gui_getInputField( propMoreY, newString );
			oldNumeric = itm_getProperty( serial, IP_MOREPOSITION, IP2_Z );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MOREPOSITION, IP2_Z, newNumeric );
			//
			// Finish
			//
			itemPropsRespExit( updateItem, serial, pc, page, edit );
			return;
		}
		if( page == 8 )
		{
			//
			// process changes to: Multi Serial
			// --------------------------------
			//
			gui_getInputField( propMultiSerial, newString );
			oldNumeric = itm_getProperty( serial, IP_MULTISERIAL, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MULTISERIAL, _, newNumeric );
			//
			// process changes to: Murder time
			// -------------------------------
			//
			gui_getInputField( propMurderTime, newString );
			oldNumeric = itm_getProperty( serial, IP_MURDERTIME, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_MURDERTIME, _, newNumeric );
			//
			// process changes to: Name current
			// --------------------------------
			//
			gui_getInputField( propNameCurrent, newString );
			trim( newString );
			itm_getProperty( serial, IP_STR_NAME, _, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( newString ) > 29 )
					newString{29} = 0;
				itm_setProperty( serial, IP_STR_NAME, _, newString );
			}
			//
			// process changes to: Name real
			// -----------------------------
			//
			gui_getInputField( propNameReal, newString );
			trim( newString );
			itm_getProperty( serial, IP_STR_NAME2, _, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( newString ) > 29 )
					newString{29} = 0;
				itm_setProperty( serial, IP_STR_NAME2, _, newString );
			}
			//
			// process changes to: Newbie
			// --------------------------
			//
			gui_getInputField( propNewbie, newString );
			oldNumeric = (itm_getProperty( serial, IP_PRIV, _) & 0x02);
			newNumeric = prop2Boolean( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				if( newNumeric )
					itm_setProperty( serial, IP_PRIV, _, itm_getProperty( serial, IP_PRIV, _) | 0x02 );
				else
					itm_setProperty( serial, IP_PRIV, _, itm_getProperty( serial, IP_PRIV, _) & ~0x02 );
			}
			//
			// process changes to: Owner Serial
			// --------------------------------
			//
			gui_getInputField( propOwnerSerial, newString );
			oldNumeric = itm_getProperty( serial, IP_OWNERSERIAL, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_OWNERSERIAL, _, newNumeric );
			//
			// process changes to: Pileable
			// ----------------------------
			//
			gui_getInputField( propPileable, newString );
			oldNumeric = itm_getProperty( serial, IP_PILEABLE, _);
			newNumeric = prop2Boolean( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				if( newNumeric )
					newNumeric = oldNumeric;
				else
					newNumeric = oldNumeric;
				itm_setProperty( serial, IP_PILEABLE, _, newNumeric );
			}
			//
			// process changes to: Poisoned
			// ----------------------------
			//
			// TODO validation
			//
			gui_getInputField( propPoisoned, newString );
			oldNumeric = itm_getProperty( serial, IP_POISONED, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_POISONED, _, newNumeric );
			//
			// process changes to: Random value rate
			// -------------------------------------
			//
			gui_getInputField( propRndValueRate, newString );
			oldNumeric = itm_getProperty( serial, IP_RNDVALUERATE, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_RNDVALUERATE, _, newNumeric );
			//
			// process changes to: Rank
			// ------------------------
			//
			gui_getInputField( propRank, newString );
			oldNumeric = itm_getProperty( serial, IP_RANK, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_RANK, _, newNumeric );
			//
			// Finish
			//
			itemPropsRespExit( updateItem, serial, pc, page, edit );
			return;
		}
		if( page == 9 )
		{
			//
			// process changes to: Restock
			// ---------------------------
			//
			gui_getInputField( propRestock, newString );
			oldNumeric = itm_getProperty( serial, IP_RESTOCK, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_RESTOCK, _, newNumeric );
			//
			// process changes to: Script id
			// -----------------------------
			//
			gui_getInputField( propScriptId, newString );
			oldNumeric = itm_getProperty( serial, IP_SCRIPTID, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_SCRIPTID, _, newNumeric );
			//
			// process changes to: Secure
			// --------------------------
			//
			gui_getInputField( propSecure, newString );
			oldNumeric = itm_getProperty( serial, IP_SECUREIT, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_SECUREIT, _, newNumeric );
			//
			// process changes to: Serial
			// --------------------------
			//
			// TODO - Make sure a valid unused item serial has been entered
			//
			gui_getInputField( propSerial, newString );
			oldNumeric = itm_getProperty( serial, IP_SERIAL, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_SERIAL, _, newNumeric );
			//
			// process changes to: Skill required
			// ----------------------------------
			//
			gui_getInputField( propSkillRequired, newString );
			oldNumeric = itm_getProperty( serial, IP_REQSKILL, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_REQSKILL, _, newNumeric );
			//
			// process changes to: Smelt
			// -------------------------
			//
			gui_getInputField( propSmelt, newString );
			oldNumeric = itm_getProperty( serial, IP_SMELT, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_SMELT, _, newNumeric );
			//
			// process changes to: Spawn region
			// --------------------------------
			//
			gui_getInputField( propSpawnRegion, newString );
			oldNumeric = itm_getProperty( serial, IP_SPAWNREGION, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_SPAWNREGION, _, newNumeric );
			//
			// process changes to: Spawn serial
			// --------------------------------
			//
			gui_getInputField( propSpawnSerial, newString );
			oldNumeric = itm_getProperty( serial, IP_SPAWNSERIAL, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_SPAWNSERIAL, _, newNumeric );
			//
			// process changes to: Speed
			// -------------------------
			//
			gui_getInputField( propSpeed, newString );
			oldNumeric = itm_getProperty( serial, IP_SPEED, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_SPEED, _, newNumeric );
			//
			// process changes to: Strength bonus
			// ----------------------------------
			//
			gui_getInputField( propStrBonus, newString );
			oldNumeric = itm_getProperty( serial, IP_STRBONUS, _ );
			newNumeric = prop2Signed( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_STRBONUS, _, newNumeric );
			//
			// Finish
			//
			itemPropsRespExit( updateItem, serial, pc, page, edit );
			return;
		}
		if( page == 10 )
		{
			//
			// process changes to: Strength required
			// -------------------------------------
			//
			gui_getInputField( propStrRequired, newString );
			oldNumeric = itm_getProperty( serial, IP_STRREQUIRED, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_STRREQUIRED, _, newNumeric );
			//
			// process changes to: Trigger
			// ---------------------------
			//
			gui_getInputField( propTrigger, newString );
			oldNumeric = itm_getProperty( serial, IP_TRIGGER, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_TRIGGER, _, newNumeric );
			//
			// process changes to: Trigger uses
			// --------------------------------
			//
			gui_getInputField( propTriggerUses, newString );
			oldNumeric = itm_getProperty( serial, IP_TRIGGERUSES, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_TRIGGERUSES, _, newNumeric );
			//
			// process changes to: Trigger type
			// --------------------------------
			//
			gui_getInputField( propTriggerType, newString );
			oldNumeric = itm_getProperty( serial, IP_TRIGTYPE, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_TRIGTYPE, _, newNumeric );
			//
			// process changes to: Type
			// ------------------------
			//
			gui_getInputField( propType, newString );
			oldNumeric = itm_getProperty( serial, IP_TYPE, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_TYPE, _, newNumeric );
			//
			// process changes to: Type2
			// -------------------------
			//
			gui_getInputField( propType2, newString );
			oldNumeric = itm_getProperty( serial, IP_TYPE2, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_TYPE2, _, newNumeric );
			//
			// process changes to: Value
			// -------------------------
			//
			gui_getInputField( propValue, newString );
			oldNumeric = itm_getProperty( serial, IP_VALUE, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_VALUE, _, newNumeric );
			//
			// process changes to: Visible to
			// ------------------------------
			//
			gui_getInputField( propVisible, newString );
			newStringLength = strlen( newString );
			if( newStringLength )
			{
				trim( newString );
				str2lower( newString );
				oldNumeric = itm_getProperty( serial, IP_VISIBLE, _);
				if( !strcmp( newString, "all" ) || (isStrUnsignedInt( newString ) && str2UnsignedInt( newString ) == 0) || (isStrHex( newString ) && str2Hex( newString ) == 0 ) )
					newNumeric = 0;
				else
					if( !strcmp( newString, "owner" ) || (isStrUnsignedInt( newString ) && str2UnsignedInt( newString ) == 1) || (isStrHex( newString ) && str2Hex( newString ) == 1 ) )
						newNumeric = 1;
					else
						if( !strcmp( newString, "gm" ) || (isStrUnsignedInt( newString ) && str2UnsignedInt( newString ) == 2) || (isStrHex( newString ) && str2Hex( newString ) == 2 ) )
							newNumeric = 2;
						else
							newNumeric = oldNumeric;
				if( newNumeric != oldNumeric )
				{
					itm_setProperty( serial, IP_VISIBLE, _, newNumeric );
					updateItem = 1;
				}
			}
			//
			// Finish
			//
			itemPropsRespExit( updateItem, serial, pc, page, edit );
			return;
		}
		if( page == 11 )
		{
			//
			// process changes to: Visual Id
			// -----------------------------
			//
			gui_getInputField( propVisualId, newString );
			oldNumeric = itm_getDualByteProperty( serial, IP_ID );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				itm_setDualByteProperty( serial, IP_ID, newNumeric );
				updateItem = 1;
			}
			//
			// process changes to: Weight
			// --------------------------
			//
			gui_getInputField( propWeight, newString );
			oldNumeric = itm_getProperty( serial, IP_WEIGHT, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_WEIGHT, _, newNumeric );
			//
			// process changes to: Wipe
			// ------------------------
			//
			// TODO check wether this shouldn't be boolean
			//
			gui_getInputField( propWipe, newString );
			oldNumeric = itm_getProperty( serial, IP_WIPE, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				itm_setProperty( serial, IP_WIPE, _, newNumeric );
			//
			// Finish
			//
			itemPropsRespExit( updateItem, serial, pc, page, edit );
			return;
		}
		if( page > 11 )
		{
			//
			// Process user defined variables
			//
			new lastVar	= (page - 11) * 10;
			new firstVar	= lastVar - 9;
			new userVar = itm_firstLocalVar( serial );
			for( new varIndex = 1; varIndex < firstVar; ++varIndex )
				userVar = itm_nextLocalVar( serial, userVar );
			do
			{
				if( userVar != -1 )
				{
					if( gui_getInputField( propLocalVariables + userVar, newString ) )
					{
						if( itm_isaLocalVar( serial, userVar, VAR_TYPE_STRING ) )
						{
							itm_getLocalStrVar( serial, userVar, oldString );
							if( strcmp( newString, oldString ) )
								itm_setLocalStrVar( serial, userVar, newString );
						}
						else
						{
							trim( newString );
							oldNumeric = itm_getLocalIntVar( serial, userVar );
							if( isStrInt( newString ) )
								newNumeric = str2Int( newString );
							else
								if( isStrHex( newString ) )
									newNumeric = str2Hex( newString );
								else
									newNumeric = oldNumeric;
							if( newNumeric != oldNumeric )
								itm_setLocalIntVar( serial, userVar, newNumeric );
						}
					}
					userVar = itm_nextLocalVar( serial, userVar );
				}
			}
			while( ++firstVar <= lastVar )
			//
			// Finish
			//
			itemPropsRespExit( updateItem, serial, pc, page, edit )
			return;
		}
		//
		// Failsafe Finish
		//
		itemPropsRespExit( updateItem, serial, pc, 1, edit )
		return;
	}
}

static itemPropsRespInit( const button, &edit, &page )
{
	if( button > lastPage )
		if( button > lastPage * 2 )
		{
			page = button - lastPage * 2; // edit gump
			edit = 1;
		}
		else
		{
			page = button - lastPage; // read gump
			edit = 0;
		}
	else
	{
		page = button; // button apply respond from edit gump;
		edit = 1;
	}

	stringMode = getStringMode();
	//
	// switch to packed string mode
	//
	if( !stringMode )
		setStringMode( 1 );

}

static itemPropsRespExit( const updateItem, const itemSerial, const pc, const page, const edit )
{
		//
		// Show alterations if necessary
		//
		if( updateItem )
			itm_refresh( itemSerial );
		//
		// reset original stringmode
		//
		setStringMode( stringMode );
		itemPropsPage( itemSerial, pc, edit, page );
}

static itemPropsPage( const clickedItem, const showToWhom, const edit, const page )
{
	rowDistance	= rowSpacing + rowHeight;
	col2X		= col1X + col1Len + colSpacing;
	col1XTxt	= col1X + 5;
	col2XTxt	= col2X + 5;

	gui_delete( GUI_ITEMPROP );
	if( gui_create( GUI_ITEMPROP, 0, 0, 1, 1, 1, clickedItem ) )
	{
		//
		// VARIABLES
		//
		new str[50];
		new str1[50];
		lastPage	= 11 + ( itm_countLocalVar( clickedItem ) / 10 ) + ( itm_countLocalVar( clickedItem ) % 10  > 0 ? 1 : 0);
		currentPageRow	= 1;
		//
		//	Background
		//
		gui_addPage( GUI_ITEMPROP, 0 );
		if( edit )
		{
			gui_addResizeGump( GUI_ITEMPROP, 0, 0, 5120, 360, 365 );
			gui_addTiledGump(  GUI_ITEMPROP,  10,  335, 342, rowHeight, colBackGump, 0 );
			gui_addButton( GUI_ITEMPROP,  15, 341, 1209, 1209, page  );
			gui_addText( GUI_ITEMPROP,  35, 337, "Apply", 45);
			gui_addButton( GUI_ITEMPROP, 335, 341, 1209, 1209, buttonCancel );
			gui_addText( GUI_ITEMPROP,  285, 337, "Cancel", 45);
		}
		else
			gui_addResizeGump( GUI_ITEMPROP, 0, 0, 5120, 360, 345 );
		//
		// 	Form Title
		//
		rowY = 10;
		gui_addTiledGump( GUI_ITEMPROP,  10,  rowY, 342, rowHeight, colBackGump, 0 );
		gui_addText( GUI_ITEMPROP, 90, rowY+2, "NoX-Wizard - Item Properties", 45);
		gui_addPage( GUI_ITEMPROP, 1 );
		//
		// 	Item properties
		//
		if( page == 1 )
		{
			addProperty( "Class", "Item" );
			//
			//	Item type descriptions from UOX3
			//	TODO: check them against NoX
			//
			switch( itm_getProperty( clickedItem, IP_TYPE, _) )
			{
				case	0	:	str = !"Default";
				case	1	:	str = !"Container";
				case	2	:	str = !"Ordergate";
				case	3	:	str = !"Ordergate opener";
				case	4	:	str = !"Chaosgate";
				case	5	:	str = !"Chaosgate opener";
				case	6	:	str = !"Teleporter rune";
				case	7	:	str = !"Key";
				case	8	:	str = !"Locked container";
				case	9	:	str = !"Spellbook";
				case	10	:	str = !"Map";
				case	11	:	str = !"Book";
				case	12	:	str = !"Unlocked door";
				case	13	:	str = !"Locked door";
				case	14	:	str = !"Food";
				case	15	:	str = !"Magic wand/weapon";
				case	16	:	str = !"Resurrection";
				case	17	:	str = !"Full mortar";
				case	18	:	str = !"Enchanted item";
				case	19	:	str = !"Potion";
				case	35	:	{
								if( itm_getDualByteProperty( clickedItem, IP_ID ) == 0x14F0 )
									str = !"Townstone deed"
								else
									str = !"Townstone";
							}
				case	50	:	str = !"Recall rune";
				case	51	:	str = !"Start gate";
				case	52	:	str = !"End gate";
				case	60	:	str = !"Object teleporter";
				case	61	:	str = !"Item spawner";
				case	62	:	str = !"Npc spawner";
				case	63	:	str = !"Item spawn container";
				case	64	:	str = !"Locked item spawn container";
				case	65	:	str = !"Unlockable item spawn container";
				case	69	:	str = !"Area spawner";
				case	80	:	str = !"Single use advance gate";
				case	81	:	str = !"Multi use advance gate";
				case	82	:	str = !"Monster gate";
				case	83	:	str = !"Race gate";
				case	85	:	str = !"Damage object";
				case	86	:	str = !"Sound object";
				case	87	:	str = !"Trash container";
				case	88	:	str = !"Sound when in vicinity";
				case	100	:	str = !"Hide/unhide";
				case	101	:	str = !"Morph";
				case	102	:	str = !"Unmorph";
				case	103	:	str = !"Amry enlist"
				case	104	:	str = !"Teleport";
				case	105	:	str = !"Drink";
				case	117	:	str = !"Boat";
				case	125	:	str = !"Escort spawner";
				case	181	:	str = !"Fireworks wand";
				case	185	:	str = !"Smokeable";
				case	186	:	str = !"Rename deed";
				case	202	:	str = !"Guildstone deed";
				case	203	:	str = !"House gump opener";
				case	204	:	str = !"Slotmachine";
				case	205	:	str = !"Order/Chaos gate";
				case	206	:	str = !"Order/Chaos gate key";
				case	217	:	str = !"Player vendor deed";
				case	255	:	str = !"Worldforge type";
				case	301	:	str = !"Treasure map";
				case	302	:	str = !"Deciphered map";
				case	401	:	str = !"Jail ball";
				case	404	:	str = !"Wand";
				default		:	str = !"Unknown";
			}
			addProperty( "", str, 0, 1, 0 );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_AMOUNT, _) );
			if ( itm_getProperty( clickedItem, IP_TYPE, _) == 61 || itm_getProperty( clickedItem, IP_TYPE, _) == 62 )
				addProperty( "Amount to spawn", str, 0, 0, ( edit ? propAmount : 0 ) );
			else
				addProperty( "Amount", str, 0, 0, ( edit ? propAmount : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_AMOUNT2, _) );
			addProperty( "Amount2", str, 0, 0, ( edit ? propAmount2 : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_ANIMID, _) );
			addProperty( "Animation", str, 0, 0, ( edit ? propAnimation : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_ATT, _) );
			addProperty( "Attack", str, 0, 0, ( edit ? propAttack : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_CARVE, _) );
			addProperty( "Carve", str, 0, 0, ( edit ? propCarve : 0 ) );
			//
			sprintf( str, "%d", itm_getDualByteProperty( clickedItem, IP_COLOR) );
			addProperty( "Color", str, 0, 0, ( edit ? propColor : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_CONTAINERSERIAL, _) );
			addProperty( "Container serial (current)", str, 0, 0, ( edit ? propContainedIn : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_OLDCONTAINERSERIAL, _) );
			addProperty( "Container serial (old)", str, 0, 0, ( edit ? propContainedInOld : 0 ) );
		}
		if( page == 2 )
		{
			//
			itm_getProperty( clickedItem, IP_STR_CREATOR, _, str );
			addProperty( "Creator", str, 0, 0, ( edit ? propCreator : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_LODAMAGE, _) );
			addProperty( "Damage (low)", str, 0, 0, ( edit ? propDamageLow : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_HIDAMAGE, _) );
			addProperty( "Damage (high)", str, 0, 0, ( edit ? propDamageHigh : 0 ) );
			//
			addProperty( "Decay", ((itm_getProperty( clickedItem, IP_PRIV, _)&0x1) ? "True" : "False" ), 0, 0, ( edit ? propDecay : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_DECAYTIME, _) );
			addProperty( "Decay time", str, 0, 0, ( edit ? propDecayTime : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_DEF, _) );
			addProperty( "Defence", str, 0, 0, ( edit ? propDefence : 0 ) );
			//
			itm_getProperty( clickedItem, IP_STR_DESCRIPTION, _, str );
			addProperty( "Description (vendor)", str, 0, 0, ( edit ? propDescription : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_DEXBONUS, _) );
			addProperty( "Dexterity bonus", str, 0, 0, ( edit ? propDexBonus : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_DEXREQUIRED, _) );
			addProperty( "Dexterity reuired", str, 0, 0, ( edit ? propDexRequired : 0 ) );
			switch( itm_getProperty( clickedItem, IP_DIR, _ ) )
			{
				case 0 : str = "North";
				case 1 : str = "North-East";
				case 2 : str = "East";
				case 3 : str = "South-East";
				case 4 : str = "South";
				case 5 : str = "South-West";
				case 6 : str = "West";
				case 7 : str = "North-West";
				default: str = "Unknown";
			}
			addProperty( "Direction", str, 0, 0, ( edit ? propDirection : 0 ));
		}
		if( page == 3 )
		{
			//
			// todo boolean disabled status
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_STR_DISABLEDMSG, _) );
			addProperty( "Disabled message", str, 0, 0, ( edit ? propDisabledMsg : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_DISABLED, _) );
			addProperty( "Disabled time", str, 0, 0, ( edit ? propDisabledTime : 0 ) );
			//
			addProperty( "Dispellable", ((itm_getProperty( clickedItem, IP_PRIV, _)&0x4) ? "True" : "False" ), 0, 0, ( edit ? propDispellable : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_DOORDIR, _) );
			addProperty( "Door dir", str, 0, 0, ( edit ? propDoorDir : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_DOOROPEN, _) );
			addProperty( "Door open", str, 0, 0, ( edit ? propDoorOpen : 0 ) );
			//
			addProperty( "Dyeable", (itm_getProperty( clickedItem, IP_DYE, _) ? "True" : "False" ), 0, 0, ( edit ? propDyeable : 0 ) );
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONDAMAGE, str );
			addProperty( "Event damage", str, 0, 0, ( edit ? propOnDamage : 0 ) );
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONEQUIP, str );
			addProperty( "Event equip", str, 0, 0, ( edit ? propOnEquip : 0 ) );
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONUNEQUIP, str );
			addProperty( "Event unequip", str, 0, 0, ( edit ? propOnUnequip : 0 ) );
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONCLICK, str );
			addProperty( "Event click", str, 0, 0, ( edit ? propOnClick : 0 ) );
		}
		if( page == 4 )
		{
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONDBLCLICK, str );
			addProperty( "Event double click", str, 0, 0, ( edit ? propOnDoubleClick : 0 ) );
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONPUTINBACKPACK, str );
			addProperty( "Event put in backpack", str, 0, 0, ( edit ? propOnPutInpack : 0 ));
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONDROPINLAND, str );
			addProperty( "Event drop in land", str, 0, 0, ( edit ? propOnDropInLand : 0 ) );
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONCHECKCANUSE, str );
			addProperty( "Event check can use", str, 0, 0, ( edit ? propOnCheckCanUse : 0 ) );
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONTRANSFER, str );
			addProperty( "Event transfer", str, 0, 0, ( edit ? propOnTransfer : 0 ) );
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONSTOLEN, str );
			addProperty( "Event stolen", str, 0, 0, ( edit ? propOnStolen : 0 ));
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONPOISONED, str );
			addProperty( "Event poisoned", str, 0, 0, ( edit ? propOnPoisoned : 0 ));
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONDECAY, str );
			addProperty( "Event decay", str, 0, 0, ( edit ? propOnDecay : 0 ));
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONREMOVETRAP, str );
			addProperty( "Event remove trap", str, 0, 0, ( edit ? propOnRemoveTrap : 0 ));
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONLOCKPICK, str );
			addProperty( "Event lockpick", str, 0, 0, ( edit ? propOnLockPick : 0 ));
		}
		if( page == 5 )
		{
			//
			itm_getEventHandler( clickedItem, EVENT_ITM_ONWALKOVER, str );
			addProperty( "Event walk over", str, 0, 0, ( edit ? propOnWalkOver : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_GATENUMBER, _) );
			addProperty( "Gate number", str, 0, 0, ( edit ? propGateNumber : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_GATETIME, _) );
			addProperty( "Gate time", str, 0, 0, ( edit ? propGateTime : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_GLOW, _) );
			addProperty( "Glow", str, 0, 0, ( edit ? propGlow : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_GLOWFX, _) );
			addProperty( "GlowFx", str, 0, 0, ( edit ? propGlowFx : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_GOOD, _) );
			addProperty( "Good", str, 0, 0, ( edit ? propGood : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_HP, _) );
			addProperty( "Hit points", str, 0, 0, ( edit ? propHitPoints : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_MAXHP, _) );
			addProperty( "Hit points (max)", str, 0, 0, ( edit ? propHitPointsMax : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_INCOGNITO, _) );
			addProperty( "Incognito", str );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_INTBONUS, _) );
			addProperty( "Intelligence bonus", str, 0, 0, ( edit ? propIntBonus : 0 ) );
		}
		if( page == 6 )
		{
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_INTREQUIRED, _) );
			addProperty( "Intelligence required", str, 0, 0, ( edit ? propIntRequired : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_ITEMHAND, _) );
			addProperty( "Item hand", str, 0, 0, ( edit ? propItemHand : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_LAYER, _) );
			addProperty( "Layer (current)", str, 0, 0, ( edit ? propLayerCurrent : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_OLDLAYER, _) );
			addProperty( "Layer (old)", str, 0, 0, ( edit ? propLayerOld : 0 ) );
			//
			sprintf( str, "%d %d %d",itm_getProperty( clickedItem, IP_POSITION, IP2_X ),
						itm_getProperty( clickedItem, IP_POSITION, IP2_Y ),
						itm_getProperty( clickedItem, IP_POSITION, IP2_Z ));
			addProperty( "Location (current)", str, 0, 0, ( edit ? propLocation : 0 ) );
			//
			sprintf( str, "%d %d %d",itm_getProperty( clickedItem, IP_OLDPOSITION, IP2_X ),
						itm_getProperty( clickedItem, IP_OLDPOSITION, IP2_Y ),
						itm_getProperty( clickedItem, IP_OLDPOSITION, IP2_Z ));
			addProperty( "Location (old)", str, 0, 0, ( edit ? propLocationOld : 0 ) );
			//
			if( itm_getProperty( clickedItem, IP_TYPE, _) != 61 && itm_getProperty( clickedItem, IP_TYPE, _) != 62 )
			{
				sprintf( str, "%d %d %d",itm_getProperty( clickedItem, IP_MOREPOSITION, IP2_X ),
					 itm_getProperty( clickedItem, IP_MOREPOSITION, IP2_Y ),
					 itm_getProperty( clickedItem, IP_MOREPOSITION, IP2_Z ));
				addProperty( "Location (more)", str, 0, 0, ( edit ? propLocationMore : 0 ) );
			}
			else
			{
				addProperty( "Location (more)", "n/a" );
			}
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_MADEWITH, _) );
			addProperty( "Made with", str, 0, 0, ( edit ? propMadeWith : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_MAGIC, _) );
			addProperty( "Magic", str, 0, 0, ( edit ? propMagic : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_MORE, 1) );
			addProperty( "More 1", str, 0, 0, ( edit ? propMore1 : 0 ) );
		}
		if( page == 7 )
		{
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_MORE, 2) );
			addProperty( "More 2", str, 0, 0, ( edit ? propMore2 : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_MORE, 3) );
			addProperty( "More 3", str, 0, 0, ( edit ? propMore3 : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_MORE, 4) );
			addProperty( "More 4", str, 0, 0, ( edit ? propMore4 : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_MOREB, 1) );
			addProperty( "MoreB 1", str, 0, 0, ( edit ? propMoreB1 : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_MOREB, 2) );
			addProperty( "MoreB 2", str, 0, 0, ( edit ? propMoreB2 : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_MOREB, 3) );
			addProperty( "MoreB 3", str, 0, 0, ( edit ? propMoreB3 : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_MOREB, 4) );
			addProperty( "MoreB 4", str, 0, 0, ( edit ? propMoreB4 : 0 ) );
			//
			if	( itm_getProperty( clickedItem, IP_TYPE, _) == 61 )
			{
				sprintf( str, "%d", itm_getProperty( clickedItem, IP_MOREPOSITION, IP2_X ) );
				addProperty( "Item to spawn", str, 0, 0, ( edit ? propMoreX : 0 ) );
				sprintf( str, "%d", itm_getProperty( clickedItem, IP_MOREPOSITION, IP2_Y ) );
				addProperty( "Min spawn time", str, 0, 0, ( edit ? propMoreY : 0 ) );
				sprintf( str, "%d", itm_getProperty( clickedItem, IP_MOREPOSITION, IP2_Z ) );
				addProperty( "Max spawn time", str, 0, 0, ( edit ? propMoreZ : 0 ) );
			}
			else if	( itm_getProperty( clickedItem, IP_TYPE, _) == 62 )
			{
				sprintf( str, "%d", itm_getProperty( clickedItem, IP_MOREPOSITION, IP2_X ) );
				addProperty( "Npc to spawn", str, 0, 0, ( edit ? propMoreX : 0 ) );
				sprintf( str, "%d", itm_getProperty( clickedItem, IP_MOREPOSITION, IP2_Y ) );
				addProperty( "Min spawn time", str, 0, 0, ( edit ? propMoreY : 0 ) );
				sprintf( str, "%d", itm_getProperty( clickedItem, IP_MOREPOSITION, IP2_Z ) );
				addProperty( "Max spawn time", str, 0, 0, ( edit ? propMoreZ : 0 ) );
			}
			else
			{
				sprintf( str, "%d", itm_getProperty( clickedItem, IP_MOREPOSITION, IP2_X ) );
				addProperty( "MoreX", str, 0, 0, ( edit ? propMoreX : 0 ) );
				sprintf( str, "%d", itm_getProperty( clickedItem, IP_MOREPOSITION, IP2_Y ) );
				addProperty( "MoreY", str, 0, 0, ( edit ? propMoreY : 0 ) );
				sprintf( str, "%d", itm_getProperty( clickedItem, IP_MOREPOSITION, IP2_Z ) );
				addProperty( "MoreZ", str, 0, 0, ( edit ? propMoreZ : 0 ) );
			}
		}
		if( page == 8 )
		{
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_MULTISERIAL, _) );
			addProperty( "Multi serial", str, 0, 0, ( edit ? propMultiSerial : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_MURDERTIME, _) );
			addProperty( "Murder time", str, 0, 0, ( edit ? propMurderTime : 0 ) );
			//
			itm_getProperty( clickedItem, IP_STR_NAME, _, str );
			addProperty( "Name (current)", str, 0, 0, ( edit ? propNameCurrent : 0 ) );
			//
			itm_getProperty( clickedItem, IP_STR_NAME2, _, str );
			addProperty( "Name (real)", str, 0, 0, ( edit ? propNameReal : 0 ) );
			//
			addProperty( "Newbie", ((itm_getProperty( clickedItem, IP_PRIV, _)&0x2) ? "True" : "False" ), 0, 0, ( edit ? propNewbie : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_OWNERSERIAL, _) );
			addProperty( "Owner serial", str, 0, 0, ( edit ? propOwnerSerial : 0 ) );
			//
			addProperty( "Pileable", ((itm_getProperty( clickedItem, IP_PILEABLE, _)) ? "True" : "False" ), 0, 0, ( edit ? propPileable : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_POISONED, _) );
			addProperty( "Poisoned", str, 0, 0, ( edit ? propPoisoned : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_RNDVALUERATE, _) );
			addProperty( "Random value rate", str, 0, 0, ( edit ? propRndValueRate : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_RANK, _) );
			addProperty( "Rank", str, 0, 0, ( edit ? propRank : 0 ) );
		}
		if( page == 9 )
		{
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_RESTOCK, _) );
			addProperty( "Restock", str, 0, 0, ( edit ? propRestock : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_SCRIPTID, _) );
			addProperty( "Script", str, 0, 0, ( edit ? propScriptId : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_SECUREIT, _) );
			addProperty( "Secure", str, 0, 0, ( edit ? propSecure : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_SERIAL, _) );
			addProperty( "Serial", str, 0, 0, ( edit ? propSerial : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_REQSKILL, _) );
			addProperty( "Skill required", str, 0, 0, ( edit ? propSkillRequired : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_SMELT, _) );
			addProperty( "Smelt", str, 0, 0, ( edit ? propSmelt : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_SPAWNREGION, _) );
			addProperty( "Spawn region", str, 0, 0, ( edit ? propSpawnRegion : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_SPAWNSERIAL, _) );
			addProperty( "Spawn serial", str, 0, 0, ( edit ? propSpawnSerial : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_SPEED, _) );
			addProperty( "Speed", str, 0, 0, ( edit ? propSpeed : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_STRBONUS, _) );
			addProperty( "Strength bonus", str, 0, 0, ( edit ? propStrBonus : 0 ) );
		}
		if( page == 10 )
		{
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_STRREQUIRED, _) );
			addProperty( "Strength required", str, 0, 0, ( edit ? propStrRequired : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_TIME_UNUSED, _) );
			addProperty( "Time unused", str );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_TIME_UNUSEDLAST, _) );
			addProperty( "Time used last", str );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_TRIGGER, _) );
			addProperty( "Trigger", str, 0, 0, ( edit ? propTrigger : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_TRIGGERUSES, _) );
			addProperty( "Trigger uses", str, 0, 0, ( edit ? propTriggerUses : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_TRIGTYPE, _) );
			addProperty( "Trigger type", str, 0, 0, ( edit ? propTriggerType : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_TYPE, _) );
			addProperty( "Type", str, 0, 0, ( edit ? propType : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_TYPE2, _) );
			addProperty( "Type", str, 0, 0, ( edit ? propType2 : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_VALUE, _) );
			addProperty( "Value", str, 0, 0, ( edit ? propValue : 0 ) );
			//
			switch( itm_getProperty( clickedItem, IP_VISIBLE, _) )
			{
				case 0 : str = "All";
				case 1 : str = "Owner";
				case 2 : str = "GM";
				default: str = "Unknown";
			}
			addProperty( "Visible to", str, 0, 0, ( edit ? propVisible : 0 ) );
		}
		if( page == 11 )
		{
			//
			sprintf( str, "%d", itm_getDualByteProperty( clickedItem, IP_ID ) );
			addProperty( "Visual id", str, 0, 0, ( edit ? propVisualId : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_WEIGHT, _) );
			addProperty( "Weight", str, 0, 0, ( edit ? propWeight : 0 ) );
			//
			sprintf( str, "%d", itm_getProperty( clickedItem, IP_WIPE, _) );
			addProperty( "Wipe", str, 0, 0, ( edit ? propWipe : 0 ) );
			//
			addProperty( "", "" );
			//
			addProperty( "", "" );
			//
			addProperty( "", "" );
			//
			addProperty( "", "" );
			//
			addProperty( "", "" );
			//
			addProperty( "", "" );
			//
			addProperty( "", "" );
		}
		if( page > 11 )
		{
			new lastVar	= (page - 11) * 10;
			new firstVar	= lastVar - 9;
			new userVar = itm_firstLocalVar( clickedItem );
			for( new varIndex = 1; varIndex < firstVar; ++varIndex )
				userVar = itm_nextLocalVar( clickedItem, userVar );
			do
			{
				if( userVar != -1 )
				{
					if( itm_isaLocalVar( clickedItem, userVar, VAR_TYPE_STRING ) )
					{
						sprintf( str, "Local str var %d", userVar );
						itm_getLocalStrVar( clickedItem, userVar, str1 )
					}
					else
					{
						sprintf( str, "Local int var %d", userVar );
						sprintf( str1, "%d", itm_getLocalIntVar( clickedItem, userVar ) );
					}
					addProperty( str, str1, 0, 0, ( edit ? propLocalVariables + userVar : 0 ) );
					userVar = itm_nextLocalVar( clickedItem, userVar );
				}
			}
			while( ++firstVar <= lastVar )
		}
		addToolBars( page, edit );
		//
		gui_show( GUI_ITEMPROP, showToWhom );
		gui_delete( GUI_ITEMPROP );
	}
	else
		printf(!"Error failed to create item property gump^n");
}

static addProperty( const colVal1[], colVal2[], const cropCol1 = 0, const cropCol2 = 0, const editField = 0 )
{
	rowY += rowDistance;
	gui_addTiledGump( GUI_ITEMPROP, col1X,   rowY,   col1Len, rowHeight, colBackGump, 0 );
	if ( cropCol1 )
		gui_addCroppedText( GUI_ITEMPROP, col1XTxt, rowY+2, col1Len, rowHeight, colVal1, 45);
	else
		gui_addText( GUI_ITEMPROP, col1XTxt,rowY+2, colVal1, 45);
	gui_addTiledGump( GUI_ITEMPROP, col2X,   rowY,   col2Len, rowHeight, colBackGump, 0 );
	if( editField )
		gui_addInputField( GUI_ITEMPROP, col2XTxt, rowY+2, col2Len, rowHeight, editField, colVal2, 11);
	else
		if( cropCol2 )
			gui_addCroppedText( GUI_ITEMPROP, col2XTxt,rowY+2, col2Len, rowHeight, colVal2, 45);
		else
			gui_addText( GUI_ITEMPROP, col2XTxt,rowY+2, colVal2, 45);
}

static addToolBars( const page, const edit )
{
	new pagebuttonOffset = ( edit ? lastPage * 2 : lastPage );
	rowY = 10 + rowDistance * 11;
	if( page != 1 )
	{
		gui_addButton( GUI_ITEMPROP, col1XTxt,  rowY+2, 1210, 1210, (1 + pagebuttonOffset) );
		gui_addButton( GUI_ITEMPROP,  40,  rowY+2, 1210, 1210, ( page == 1 ? (1 + pagebuttonOffset) : (pagebuttonOffset + page - 1) ) );
	}
	if( page != lastPage )
	{
		gui_addButton( GUI_ITEMPROP, 310,  rowY+2, 1210, 1210, ( page == lastPage ? (pagebuttonOffset + lastPage) : (pagebuttonOffset + page + 1) ) );
		gui_addButton( GUI_ITEMPROP, 335,  rowY+2, 1210, 1210, (pagebuttonOffset + lastPage) );
	}
	gui_addTiledGump(  GUI_ITEMPROP,  col1X,  rowY, 342, rowHeight, colBackGump, 0 );
	gui_addText(	   GUI_ITEMPROP,  col1XTxt, rowY+2, "|<", 45);
	gui_addText(	   GUI_ITEMPROP,  40, rowY+2, "<", 45);
	gui_addText(	   GUI_ITEMPROP,  312, rowY+2, ">", 45);
	gui_addText(	   GUI_ITEMPROP,  337, rowY+2, ">|", 45);
}
