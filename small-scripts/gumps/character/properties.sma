static const rowSpacing		= 2;
static const rowHeight		= 25;
static rowDistance		= 0;
static rowY			= 0;
static const colSpacing		= 2;
static const col1Len		= 170;
static const col2Len		= 170;
static const col1X		= 10;
static col2X			= 0;
static col1XTxt			= 0;
static col2XTxt			= 0;
static const colBackGump	= 0x52;
static lastPage			= 16;
static const rowsPerPage	= 12;
static currentPageRow		= 0;
static stringMode		= 0;
//
// Field identifiers
//
static const propAllMove		= 1;
static const propBody			= 2;
static const propCanBroadcast		= 3;
static const propDefence		= 4;
static const propDexterity		= 5;
static const propDirection		= 6;
static const propIntelligence		= 7;
static const propLocation		= 8;
static const propStrength		= 9;
static const propFame			= 10;
static const propKarma			= 11;
static const propHunger			= 12;
static const propName			= 13;
static const propNameReal		= 14;
static const propTitle			= 15;
static const propKills			= 16;
static const propFrozen			= 17;
static const propHouseAsIcon		= 18;
static const propAlwaysHidden		= 19;
static const propManaUnneeded		= 20;
static const propDispellable		= 21;
static const propNoReagents		= 22;
static const propGMClearance		= 23;
static const propGMPageable		= 24;
static const propShowSerials		= 25;
static const propInvulnerable		= 26;
//static const propSkillTitle		= 27;
static const propSnoopAbility		= 28;
static const propMagicReflect		= 29;
static const propShowSkill		= 30;
static const propCnclrClearance		= 31;
static const propCriminal		= 32;
static const propCommandLevel		= 33;
static const propOnDeath		= 34;
static const propOnWounded		= 35;
static const propOnHit			= 36;
static const propOnHitMiss		= 37;
static const propOnGetHit		= 38;
static const propOnReputation		= 39;
static const propOnDispel		= 40;
static const propOnResurrect		= 41;
static const propOnFlagChg		= 42;
static const propOnWalk			= 43;
static const propOnAdvanceSkill		= 44;
static const propOnAdvanceStat		= 45;
static const propOnBeginAttack		= 46;
static const propOnBeginDefence		= 47;
static const propOnTransfer		= 48;
static const propOnMultiEnter		= 49;
static const propOnMultiLeave		= 50;
static const propOnSnooped		= 51;
static const propOnStolen		= 52;
static const propOnPoisoned		= 53;
static const propOnRegionChg		= 54;
static const propOnCastSpell		= 55;
static const propOnGetSkillCap		= 56;
static const propOnGetStatCap		= 57;
static const propOnBlock		= 58;
static const propOnStart		= 59;
static const propOnHeartBeat		= 60;
static const propOnBreakMeditat		= 61;
static const propOnClick		= 62;
static const propOnMount		= 63;
static const propOnDismount		= 64;
static const propSkin			= 65;
static const propSkinOld		= 66;
static const propMurderer		= 67;
static const propMurders		= 68;
static const propWanderMode		= 69;
static const propOldWanderMode		= 70;
static const propSkillANATOMY		= 71;
static const propSkillALCHEMY		= 72;
static const propSkillANIMALLORE	= 73;
static const propSkillARCHERY		= 74;
static const propSkillARMSLORE		= 75;
static const propSkillBEGGING		= 76;
static const propSkillBLACKSMITHING	= 77;
static const propSkillBOWCRAFT		= 78;
static const propSkillCAMPING		= 79;
static const propSkillCARPENTRY		= 80;
static const propSkillCARTOGRAPHY	= 81;
static const propSkillCOOKING		= 82;
static const propSkillDETECTINGHIDDEN	= 83;
static const propSkillENTICEMENT	= 84;
static const propSkillEVALUATINGINTEL	= 85;
static const propSkillHEALING		= 86;
static const propSkillFENCING		= 87;
static const propSkillFISHING		= 89;
static const propSkillFORENSICS		= 90;
static const propSkillHERDING		= 91;
static const propSkillHIDING		= 92;
static const propSkillINSCRIPTION	= 93;
static const propSkillITEMID		= 94;
static const propSkillLOCKPICKING	= 95;
static const propSkillLUMBERJACKING	= 96;
static const propSkillMACEFIGHTING	= 97;
static const propSkillMAGERY		= 98;
static const propSkillMAGICRESISTANCE	= 99;
static const propSkillMEDITATION	= 100;
static const propSkillMINING		= 101;
static const propSkillMUSICIANSHIP	= 102;
static const propSkillPARRYING		= 103;
static const propSkillPEACEMAKING	= 104;
static const propSkillPOISONING		= 105;
static const propSkillPROVOCATION	= 106;
static const propSkillREMOVETRAPS	= 107;
static const propSkillSNOOPING		= 108;
static const propSkillSPIRITSPEAK	= 109;
static const propSkillSTEALING		= 110;
static const propSkillSTEALTH		= 111;
static const propSkillSWORDSMANSHIP	= 112;
static const propSkillTACTICS		= 113;
static const propSkillTAILORING		= 114;
static const propSkillTAMING		= 115;
static const propSkillTASTEID		= 116;
static const propSkillTINKERING		= 117;
static const propSkillTRACKING		= 118;
static const propSkillVETERINARY	= 119;
static const propSkillWRESTLING		= 120;


static const propLocalVariables	= 200;
//
// Button Identifiers
//
static const buttonCancel	= 65533;
static const buttonPreferences	= 65534;
static const buttonMinimize	= 65535;

public gui_charProps( const clickedChar, const showToWhom, const edit )
{
	charPropsPage( clickedChar, showToWhom, edit, 1 );
}

public gui_charPropsResp( const gump, const serial, const button, const pc )
{
	if( button != buttonCancel )
	{
		new page;
		new edit;
		new updateChar = 0;
		charPropsRespInit( button, edit, page );
		printf( !"page %d button %d^n", page, button );
		if( page != button )
		{
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}

		new isPlayerCharacter = ( chr_getProperty(serial, CP_NPC, _ ) ? 0 : 1);

		new newString[64];	// packed string arrays for max 256 chars including trailing '/0'
		new oldString[64];
		new newNumeric;
		new oldNumeric;
		new newStringLength;
		if( page == 1 )
		{
			//
			// process changes to: All move capability
			// ---------------------------------------
			//
			if( isPlayerCharacter )
			{
				gui_getInputField( propAllMove, newString );
				oldNumeric = (chr_getProperty( serial, CP_PRIV2, _)&0x01 ? 1 : 0);
				newNumeric = prop2Boolean( newString, oldNumeric );
				if( newNumeric != oldNumeric )
				{
					if( newNumeric )
						chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) | 0x01 );
					else
						chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) & ~0x01 );
				}
			}
			//
			// process changes to: Alchemy skill
			// ---------------------------------
			//
			gui_getInputField( propSkillALCHEMY, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_ALCHEMY );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_ALCHEMY, newNumeric );
			//
			// process changes to: Anatomy skill
			// ---------------------------------
			//
			gui_getInputField( propSkillANATOMY, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_ANATOMY );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_ANATOMY, newNumeric );
			//
			// process changes to: Animal lore skill
			// -------------------------------------
			//
			gui_getInputField( propSkillANIMALLORE, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_ANIMALLORE );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_ANIMALLORE, newNumeric );
			//
			// process changes to: Archery skill
			// ---------------------------------
			//
			gui_getInputField( propSkillARCHERY, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_ARCHERY );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_ARCHERY, newNumeric );
			//
			// process changes to: Arms lore skill
			// -----------------------------------
			//
			gui_getInputField( propSkillARMSLORE, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_ARMSLORE );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_ARMSLORE, newNumeric );
			//
			// process changes to: Begging skill
			// ---------------------------------
			//
			gui_getInputField( propSkillBEGGING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_BEGGING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_BEGGING, newNumeric );
			//
			// process changes to: Blacksmithing skill
			// ---------------------------------------
			//
			gui_getInputField( propSkillBLACKSMITHING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_BLACKSMITHING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_BLACKSMITHING, newNumeric );
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if( page == 2)
		{
			//
			// process changes to: Bowcraft skill
			// ----------------------------------
			//
			gui_getInputField( propSkillBOWCRAFT, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_BOWCRAFT );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_BOWCRAFT, newNumeric );
			//
			// process changes to: Body
			// ------------------------
			//
			gui_getInputField( propBody, newString );
			oldNumeric = chr_getDualByteProperty( serial, CP_ID );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				chr_setDualByteProperty( serial, CP_ID, newNumeric );
				updateChar = 1;
			}
			// process changes to: Broadcast ability
			// -------------------------------------
			if( isPlayerCharacter )
			{
				gui_getInputField( propCanBroadcast, newString );
				oldNumeric = (chr_getProperty( serial, CP_PRIV, _)&0x02 ? 1 : 0 );
				newNumeric = prop2Boolean( newString, oldNumeric );
				if( newNumeric != oldNumeric )
				{
					if( newNumeric )
						chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) | 0x02 );
					else
						chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) & ~0x02 );
				}
			}
			//
			// process changes to: Camping skill
			// ---------------------------------
			//
			gui_getInputField( propSkillCAMPING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_CAMPING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_CAMPING, newNumeric );
			//
			// process changes to: Carpentry skill
			// -----------------------------------
			//
			gui_getInputField( propSkillCARPENTRY, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_CARPENTRY );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_CARPENTRY, newNumeric );
			//
			// process changes to: Cartography skill
			// -------------------------------------
			//
			gui_getInputField( propSkillCARTOGRAPHY, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_CARTOGRAPHY );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_CARTOGRAPHY, newNumeric );
			//
			// process changes to: Command Level
			// --------------------------------
			//
			gui_getInputField( propCommandLevel, newString );
			oldNumeric = chr_getProperty( serial, CP_COMMANDLEVEL, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric&0x1 );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_COMMANDLEVEL, _, newNumeric );
			//
			// process changes to: Cooking skill
			// ---------------------------------
			//
			gui_getInputField( propSkillCOOKING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_COOKING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_COOKING, newNumeric );
			//
			// process changes to: Councillor clearance
			// ----------------------------------------
			//
			if( isPlayerCharacter )
			{
				gui_getInputField( propCnclrClearance, newString );
				oldNumeric = (chr_getProperty( serial, CP_PRIV, _)&0x80 ? 1 : 0 );
				newNumeric = prop2Boolean( newString, oldNumeric );
				if( newNumeric != oldNumeric )
				{
					if( newNumeric )
						chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) | 0x80 );
					else
						chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) & ~0x80 );
				}
			}
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}

		if( page == 3 )
		{
			//
			// process changes to: Criminal status
			// -----------------------------------
			//
			gui_getInputField( propCriminal, newString );
			oldNumeric = chr_getProperty( serial, CP_FLAG, _);
			newNumeric = prop2Boolean( newString, oldNumeric&0x2 );
			if( newNumeric != oldNumeric&0x2 )
			{
				if( newNumeric )
					newNumeric = oldNumeric | 0x2;
				else
					newNumeric = oldNumeric & ~0x2;
				chr_setProperty( serial, CP_FLAG, _, newNumeric );
			}
			//
			// process changes to: Defence
			// ---------------------------
			//
			gui_getInputField( propDefence, newString );
			newStringLength = strlen( newString );
			oldNumeric = chr_getProperty( serial, CP_DEF, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_DEF, _, newNumeric )
			//
			// process changes to: Detect Hidden skill
			// ---------------------------------------
			//
			gui_getInputField( propSkillDETECTINGHIDDEN, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_DETECTINGHIDDEN );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_DETECTINGHIDDEN, newNumeric );
			//
			// process changes to: Dexterity
			// -----------------------------
			//
			gui_getInputField( propDexterity, newString );
			oldNumeric = chr_getProperty( serial, CP_DEXTERITY, CP2_REAL);
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				chr_setProperty( serial, CP_DEXTERITY, CP2_REAL, newNumeric )
				updateChar = 1;
			}
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
				oldNumeric = chr_getProperty( serial, CP_DIR, _ );
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
					chr_setProperty( serial, CP_DIR, _, newNumeric );
					updateChar = 1;
				}
			}
			//
			// process changes to: Dispellable
			// -------------------------------
			//
			gui_getInputField( propDispellable, newString );
			oldNumeric = (chr_getProperty( serial, CP_PRIV2, _)&0x20 ? 1 : 0);
			newNumeric = prop2Boolean( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				if( newNumeric )
					chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) | 0x20 );
				else
					chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) & ~0x20 );
			}
			//
			// process changes to: Enticement skill
			// ------------------------------------
			//
			gui_getInputField( propSkillENTICEMENT, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_ENTICEMENT );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_ENTICEMENT, newNumeric );
			//
			// process changes to: Evaluate intelligence skill
			// -----------------------------------------------
			//
			gui_getInputField( propSkillEVALUATINGINTEL, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_EVALUATINGINTEL );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_EVALUATINGINTEL, newNumeric );
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if( page == 4 )
		{
			//
			// process changes to: Event On Death
			// ----------------------------------
			//
			gui_getInputField( propOnDeath, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONDEATH, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONDEATH );
				chr_setEventHandler( serial, EVENT_CHR_ONDEATH, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Wounded
			// ------------------------------------
			//
			gui_getInputField( propOnWounded, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONWOUNDED, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONWOUNDED );
				chr_setEventHandler( serial, EVENT_CHR_ONWOUNDED, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Hit
			// --------------------------------
			//
			gui_getInputField( propOnHit, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONHIT, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONHIT );
				chr_setEventHandler( serial, EVENT_CHR_ONHIT, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Hit Miss
			// -------------------------------------
			//
			gui_getInputField( propOnHitMiss, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONHITMISS, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONHITMISS );
				chr_setEventHandler( serial, EVENT_CHR_ONHITMISS, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Get Hit
			// ------------------------------------
			//
			gui_getInputField( propOnGetHit, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONGETHIT, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONGETHIT );
				chr_setEventHandler( serial, EVENT_CHR_ONGETHIT, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Reputation Change
			// ----------------------------------------------
			//
			gui_getInputField( propOnReputation, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONREPUTATIONCHG, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONREPUTATIONCHG );
				chr_setEventHandler( serial, EVENT_CHR_ONREPUTATIONCHG, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Dispel
			// -----------------------------------
			//
			gui_getInputField( propOnDispel, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONDISPEL, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONDISPEL );
				chr_setEventHandler( serial, EVENT_CHR_ONDISPEL, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Resurrect
			// --------------------------------------
			//
			gui_getInputField( propOnResurrect, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONRESURRECT, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONRESURRECT );
				chr_setEventHandler( serial, EVENT_CHR_ONRESURRECT, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Flag Change
			// ----------------------------------------
			//
			gui_getInputField( propOnFlagChg, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONFLAGCHG, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONFLAGCHG );
				chr_setEventHandler( serial, EVENT_CHR_ONFLAGCHG, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Walk
			// --------------------------------------
			//
			gui_getInputField( propOnWalk, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONWALK, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONWALK );
				chr_setEventHandler( serial, EVENT_CHR_ONWALK, EVENTTYPE_STATIC, newString );
			}
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if ( page == 5 )
		{
			//
			// process changes to: Event On Advance Skill
			// ------------------------------------------
			//
			gui_getInputField( propOnAdvanceSkill, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONADVANCESKILL, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONADVANCESKILL );
				chr_setEventHandler( serial, EVENT_CHR_ONADVANCESKILL, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Advance Stat
			// -----------------------------------------
			//
			gui_getInputField( propOnAdvanceStat, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONADVANCESTAT, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONADVANCESTAT );
				chr_setEventHandler( serial, EVENT_CHR_ONADVANCESTAT, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Begin Attack
			// -----------------------------------------
			//
			gui_getInputField( propOnBeginAttack, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONBEGINATTACK, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONBEGINATTACK );
				chr_setEventHandler( serial, EVENT_CHR_ONBEGINATTACK, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Begin Defense
			// ------------------------------------------
			//
			gui_getInputField( propOnBeginDefence, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONBEGINDEFENSE, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONBEGINDEFENSE );
				chr_setEventHandler( serial, EVENT_CHR_ONBEGINDEFENSE, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Transfer
			// -------------------------------------
			//
			gui_getInputField( propOnTransfer, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONTRANSFER, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONTRANSFER );
				chr_setEventHandler( serial, EVENT_CHR_ONTRANSFER, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Multi Enter
			// ----------------------------------------
			//
			gui_getInputField( propOnMultiEnter, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONMULTIENTER, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONMULTIENTER );
				chr_setEventHandler( serial, EVENT_CHR_ONMULTIENTER, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Multi Leave
			// ----------------------------------------
			//
			gui_getInputField( propOnMultiLeave, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONMULTILEAVE, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONMULTILEAVE );
				chr_setEventHandler( serial, EVENT_CHR_ONMULTILEAVE, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Snooped
			// ------------------------------------
			//
			gui_getInputField( propOnSnooped, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONSNOOPED, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONSNOOPED );
				chr_setEventHandler( serial, EVENT_CHR_ONSNOOPED, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Stolen
			// -----------------------------------
			//
			gui_getInputField( propOnStolen, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONSTOLEN, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONSTOLEN );
				chr_setEventHandler( serial, EVENT_CHR_ONSTOLEN, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Poisoned
			// -------------------------------------
			//
			gui_getInputField( propOnPoisoned, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONPOISONED, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONPOISONED );
				chr_setEventHandler( serial, EVENT_CHR_ONPOISONED, EVENTTYPE_STATIC, newString );
			}
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if( page == 6 )
		{
			//
			// process changes to: Event On Region Change
			// ------------------------------------------
			//
			gui_getInputField( propOnRegionChg, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONREGIONCHANGE, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONREGIONCHANGE );
				chr_setEventHandler( serial, EVENT_CHR_ONREGIONCHANGE, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Cast Spell
			// ---------------------------------------
			//
			gui_getInputField( propOnCastSpell, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONCASTSPELL, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONCASTSPELL );
				chr_setEventHandler( serial, EVENT_CHR_ONCASTSPELL, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Get Skill Cap
			// ------------------------------------------
			//
			gui_getInputField( propOnGetSkillCap, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONGETSKILLCAP, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONGETSKILLCAP );
				chr_setEventHandler( serial, EVENT_CHR_ONGETSKILLCAP, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Get Stat Cap
			// -----------------------------------------
			//
			gui_getInputField( propOnGetStatCap, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONGETSTATCAP, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONGETSTATCAP );
				chr_setEventHandler( serial, EVENT_CHR_ONGETSTATCAP, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Block
			// ----------------------------------
			//
			gui_getInputField( propOnBlock, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONBLOCK, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONBLOCK );
				chr_setEventHandler( serial, EVENT_CHR_ONBLOCK, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Start
			// ----------------------------------
			//
			gui_getInputField( propOnStart, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONSTART, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONSTART );
				chr_setEventHandler( serial, EVENT_CHR_ONSTART, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Heartbeat
			// --------------------------------------
			//
			gui_getInputField( propOnHeartBeat, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONHEARTBEAT, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONHEARTBEAT );
				chr_setEventHandler( serial, EVENT_CHR_ONHEARTBEAT, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Break Meditation
			// ---------------------------------------------
			//
			gui_getInputField( propOnBreakMeditat, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONBREAKMEDITATION, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONBREAKMEDITATION );
				chr_setEventHandler( serial, EVENT_CHR_ONBREAKMEDITATION, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Click
			// ----------------------------------
			//
			gui_getInputField( propOnClick, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONCLICK, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONCLICK );
				chr_setEventHandler( serial, EVENT_CHR_ONCLICK, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Event On Mount
			// ----------------------------------
			//
			gui_getInputField( propOnMount, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONMOUNT, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONMOUNT );
				chr_setEventHandler( serial, EVENT_CHR_ONMOUNT, EVENTTYPE_STATIC, newString );
			}
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if( page == 7 )
		{
			//
			// process changes to: Event On Dismount
			// -------------------------------------
			//
			gui_getInputField( propOnDismount, newString );
			trim( newString );
			chr_getEventHandler( serial, EVENT_CHR_ONDISMOUNT, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( oldString ) )
					chr_delEventHandler( serial, EVENT_CHR_ONDISMOUNT );
				chr_setEventHandler( serial, EVENT_CHR_ONDISMOUNT, EVENTTYPE_STATIC, newString );
			}
			//
			// process changes to: Fame
			// ------------------------
			//
			gui_getInputField( propFame, newString );
			newStringLength = strlen( newString );
			oldNumeric = chr_getProperty( serial, CP_FAME, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				chr_setProperty( serial, CP_FAME, _, newNumeric )
				updateChar = 1;
			}
			//
			// process changes to: Fencing skill
			// ---------------------------------
			//
			gui_getInputField( propSkillFENCING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_FENCING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_FENCING, newNumeric );
			//
			// process changes to: Fishing skill
			// ---------------------------------
			//
			gui_getInputField( propSkillFISHING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_FISHING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_FISHING, newNumeric );
			//
			// process changes to: Forensics skill
			// -----------------------------------
			//
			gui_getInputField( propSkillFORENSICS, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_FORENSICS );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_FORENSICS, newNumeric );
			//
			// process changes to: Frozen
			// --------------------------
			//
			gui_getInputField( propFrozen, newString );
			oldNumeric = (chr_getProperty( serial, CP_PRIV2, _)&0x02 ? 1 : 0);
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				if( newNumeric )
					chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) | 0x02 );
				else
					chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) & ~0x02 );
			}
			//
			// process changes to: Game master clearance
			// -----------------------------------------
			//
			if( isPlayerCharacter )
			{
				gui_getInputField( propGMClearance, newString );
				oldNumeric = (chr_getProperty( serial, CP_PRIV, _)&0x01 ? 1 : 0);
				newNumeric = prop2Boolean( newString, oldNumeric );
				if( newNumeric != oldNumeric )
				{
					if( newNumeric )
						chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) | 0x01 );
					else
						chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) & ~0x01 );
				}
			}
			//
			// process changes to: Game Master is Pageable
			// -------------------------------------------
			//
			if( isPlayerCharacter )
			{
				gui_getInputField( propGMPageable, newString );
				oldNumeric = (chr_getProperty( serial, CP_PRIV, _)&0x20 ? 1 : 0);
				newNumeric = prop2Boolean( newString, oldNumeric );
				if( newNumeric != oldNumeric )
				{
					if( newNumeric )
						chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) | 0x20 );
					else
						chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) & ~0x20 );
				}
			}
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if( page == 8 )
		{
			//
			// process changes to: Healing skill
			// ---------------------------------
			//
			gui_getInputField( propSkillHEALING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_HEALING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_HEALING, newNumeric );
			//
			// process changes to: Herding skill
			// ---------------------------------
			//
			gui_getInputField( propSkillHERDING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_HERDING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_HERDING, newNumeric );
			//
			// process changes to: Hidden Permanently
			// ---------------------------------------
			//
			gui_getInputField( propAlwaysHidden, newString );
			oldNumeric = ( chr_getProperty( serial, CP_PRIV2, _)&0x08 ? 1 : 0 );
			newNumeric = prop2Boolean( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				if( newNumeric )
					chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) | 0x08 );
				else
					chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) & ~0x08 );
				updateChar = 1;
			}
			//
			// process changes to: Hiding skill
			// --------------------------------
			//
			gui_getInputField( propSkillHIDING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_HIDING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_HIDING, newNumeric );
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if( page == 9 )
		{
			//
			// process changes to: Houses shown as icons
			// -----------------------------------------
			//
			if( isPlayerCharacter )
			{
				gui_getInputField( propHouseAsIcon, newString );
				oldNumeric = ( chr_getProperty( serial, CP_PRIV2, _)&0x04 ? 1 : 0 );
				newNumeric = prop2Boolean( newString, oldNumeric );
				if( newNumeric != oldNumeric )
				{
					if( newNumeric )
						chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) | 0x04 );
					else
						chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) & ~0x04 );
					updateChar = 1;
				}
			}
			//
			// process changes to: Hunger
			// --------------------------
			//
			gui_getInputField( propHunger, newString );
			newStringLength = strlen( newString );
			if( newStringLength )
			{
				trim( newString );
				oldNumeric = chr_getProperty( serial, CP_HUNGER, _ );
				newNumeric = prop2Unsigned( newString, oldNumeric );
				if( newNumeric >= 0 && newNumeric <= 6 && newNumeric != oldNumeric )
					chr_setProperty( serial, CP_HUNGER, _, newNumeric )
			}
			//
			// process changes to: Inscription skill
			// -------------------------------------
			//
			gui_getInputField( propSkillINSCRIPTION, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_INSCRIPTION );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_INSCRIPTION, newNumeric );
			//
			// process changes to: Intelligence
			// --------------------------------
			//
			gui_getInputField( propIntelligence, newString );
			newStringLength = strlen( newString );
			if( newStringLength )
			{
				trim( newString );
				oldNumeric = chr_getProperty( serial, CP_INTELLIGENCE, CP2_REAL );
				newNumeric = prop2Unsigned( newString, oldNumeric );
				if( newNumeric != oldNumeric )
				{
					chr_setProperty( serial, CP_INTELLIGENCE, CP2_REAL, newNumeric )
					updateChar = 1;
				}
			}
			//
			// process changes to: Invulnerable
			// --------------------------------
			//
			gui_getInputField( propInvulnerable, newString );
			oldNumeric = (chr_getProperty( serial, CP_PRIV, _)&0x04 ? 1 : 0);
			newNumeric = prop2Boolean( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				if( newNumeric )
					chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) | 0x04 );
				else
					chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) & ~0x04 );
			}
			//
			// process changes to: Item identification skill
			// ---------------------------------------------
			//
			gui_getInputField( propSkillITEMID, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_ITEMID );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_ITEMID, newNumeric );
			// TODO - needs amxwrap2 change
			//
			// process changes to: Jail time
			// -----------------------------
			//if( isPlayerCharacter )
			//{
			//	gui_getInputField( propJailTime, newString );
			//	newStringLength = strlen( newString );
			//	if( newStringLength )
			//	{
			//		trim( newString );
			//		newNumeric = -1;
			//		if( isStrUnsignedInt( newString ) )
			//			newNumeric = str2UnsignedInt( newString );
			//		else
			//			if( isStrHex( newString ) )
			//				newNumeric = str2Hex( newString );
			//		if( newNumeric != -1 && newNumeric != chr_getProperty( serial, CP_FAME, _ ) )
			//		{
			//			chr_setProperty( serial, CP_FAME, _, newNumeric )
			//		}
			//	}
			//}
			//
			// process changes to: Karma
			// -------------------------
			//
			gui_getInputField( propKarma, newString );
			oldNumeric = chr_getProperty( serial, CP_KARMA, _ );
			newNumeric = prop2Signed( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_KARMA, _, newNumeric )
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if ( page == 10 )
		{
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
					chr_setProperty( serial, CP_POSITION, CP2_X, x );
					chr_setProperty( serial, CP_POSITION, CP2_Y, y );
					chr_setProperty( serial, CP_POSITION, CP2_Z, z );
					updateChar = 1;
				}
			}
			//
			// process changes to: Lockpicking skill
			// -------------------------------------
			//
			gui_getInputField( propSkillLOCKPICKING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_LOCKPICKING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_LOCKPICKING, newNumeric );
			//
			// process changes to: Lumberjacking skill
			// ----------------------------------------
			//
			gui_getInputField( propSkillLUMBERJACKING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_LUMBERJACKING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_LUMBERJACKING, newNumeric );
			//
			// process changes to: Mace fighting skill
			// ---------------------------------------
			//
			gui_getInputField( propSkillMACEFIGHTING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_MACEFIGHTING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_MACEFIGHTING, newNumeric );
			//
			// process changes to: Magery skill
			// --------------------------------
			//
			gui_getInputField( propSkillMAGERY, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_MAGERY );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_MAGERY, newNumeric );
			//
			// process changes to: Magic reflect ability
			// -----------------------------------------
			//
			gui_getInputField( propMagicReflect, newString );
			oldNumeric = ( chr_getProperty( serial, CP_PRIV2, _)&0x40 ? 1 : 0 );
			newNumeric = prop2Boolean( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				if( newNumeric )
					chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) | 0x40 );
				else
					chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) & ~0x40 );
			}
			//
			// process changes to: Magic resistance skill
			// ------------------------------------------
			//
			gui_getInputField( propSkillMAGICRESISTANCE, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_MAGICRESISTANCE );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_MAGICRESISTANCE, newNumeric );
			//
			// process changes to: Mana not needed
			// -----------------------------------
			//
			gui_getInputField( propManaUnneeded, newString );
			oldNumeric = ( chr_getProperty( serial, CP_PRIV2, _)&0x10 ? 1 : 0 );
			newNumeric = prop2Boolean( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				if( newNumeric )
					chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) | 0x10 );
				else
					chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) & ~0x10 );
			}
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if ( page == 11 )
		{
			//
			// process changes to: Meditation skill
			// ------------------------------------
			//
			gui_getInputField( propSkillMEDITATION, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_MEDITATION );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_MEDITATION, newNumeric );
			//
			// process changes to: Mining skill
			// ---------------------------------
			//
			gui_getInputField( propSkillMINING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_MINING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_MINING, newNumeric );
			//
			// process changes to: Kills
			// -------------------------
			//
			gui_getInputField( propKills, newString );
			oldNumeric = chr_setProperty( serial, CP_KILLS, _);
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_KILLS, _, newNumeric );
			//
			// process changes to: Musicianship skill
			// --------------------------------------
			//
			gui_getInputField( propSkillMUSICIANSHIP, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_MUSICIANSHIP );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_MUSICIANSHIP, newNumeric );
			//
			// process changes to: Name
			// ------------------------
			//
			gui_getInputField( propName, newString );
			trim( newString );
			chr_getProperty( serial, CP_STR_NAME, _, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( newString ) > 29 )
					newString{29} = 0;
				chr_setProperty( serial, CP_STR_NAME, _, newString );
			}
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if ( page == 12 )
		{
			//
			// process changes to: Parry skill
			// -------------------------------
			//
			gui_getInputField( propSkillPARRYING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_PARRYING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_PARRYING, newNumeric );
			//
			// process changes to: Peacemaking skill
			// -------------------------------------
			//
			gui_getInputField( propSkillPEACEMAKING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_PEACEMAKING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_PEACEMAKING, newNumeric );
			//
			// process changes to: Poisoning skill
			// -----------------------------------
			//
			gui_getInputField( propSkillPOISONING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_POISONING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_POISONING, newNumeric );
			//
			// process changes to: Provocation skill
			// -------------------------------------
			//
			gui_getInputField( propSkillPROVOCATION, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_PROVOCATION );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_PROVOCATION, newNumeric );
			//
			// process changes to: Reagents not needed
			// ---------------------------------------
			//
			gui_getInputField( propNoReagents, newString );
			oldNumeric = ( chr_getProperty( serial, CP_PRIV2, _)&0x80 ? 1 : 0 );
			newNumeric = prop2Boolean( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				if( newNumeric )
					chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) | 0x80 );
				else
					chr_setProperty( serial, CP_PRIV2, _,  chr_getProperty( serial, CP_PRIV2, _) & ~0x80 );
			}
			//
			// process changes to: Remove traps skill
			// --------------------------------------
			//
			gui_getInputField( propSkillREMOVETRAPS, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_REMOVETRAPS );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_REMOVETRAPS, newNumeric );
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if ( page == 13 )
		{
			//
			// process changes to: Serials displayed on single click
			// -----------------------------------------------------
			//
			if( isPlayerCharacter )
			{
				gui_getInputField( propShowSerials, newString );
				oldNumeric = (chr_getProperty( serial, CP_PRIV, _)&0x08 ? 1 : 0);
				newNumeric = prop2Boolean( newString, oldNumeric );
				if( newNumeric != oldNumeric )
				{
					if( newNumeric )
						chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) | 0x08 );
					else
						chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) & ~0x08 );
				}
			}
			//
			// process changes to: Skill titles on
			// -----------------------------------
			//
			gui_getInputField( propShowSkill, newString );
			oldNumeric = (chr_getProperty( serial, CP_PRIV, _)&0x10 ? 1 : 0);
			newNumeric = prop2Boolean( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				if( newNumeric )
					chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) | 0x10 );
				else
					chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) & ~0x10 );
			}
			//
			// process changes to: Skin current
			// --------------------------------
			//
			gui_getInputField( propSkin, newString );
			newStringLength = strlen( newString );
			if( newStringLength )
			{
				trim( newString );
				oldNumeric = chr_getDualByteProperty( serial, CP_SKIN );
				newNumeric = prop2Unsigned( newString, oldNumeric );
				if( newNumeric != oldNumeric )
				{
					chr_setDualByteProperty( serial, CP_SKIN, newNumeric )
					updateChar = 1;
				}
			}
			//
			// process changes to: Skin old
			// ----------------------------
			//
			gui_getInputField( propSkinOld, newString );
			newStringLength = strlen( newString );
			if( newStringLength )
			{
				trim( newString );
				oldNumeric = chr_getDualByteProperty( serial, CP_XSKIN );
				newNumeric = prop2Unsigned( newString, oldNumeric );
				if( newNumeric != oldNumeric )
				{
					chr_setDualByteProperty( serial, CP_XSKIN, newNumeric )
					updateChar = 1;
				}
			}
			//
			// process changes to: Snoop Ability
			// ---------------------------------
			//
			gui_getInputField( propSnoopAbility, newString );
			oldNumeric = (chr_getProperty( serial, CP_PRIV, _)&0x40 ? 1 : 0);
			newNumeric = prop2Boolean( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				if( newNumeric )
					chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) | 0x40 );
				else
					chr_setProperty( serial, CP_PRIV, _,  chr_getProperty( serial, CP_PRIV, _) & ~0x40 );
			}
			//
			// process changes to: Snooping skill
			// ----------------------------------
			//
			gui_getInputField( propSkillSNOOPING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_SNOOPING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_SNOOPING, newNumeric );
			//
			// process changes to: Spiritspeak skill
			// -------------------------------------
			//
			gui_getInputField( propSkillSPIRITSPEAK, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_SPIRITSPEAK );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_SPIRITSPEAK, newNumeric );
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if ( page == 14 )
		{
			//
			// process changes to: Stealing skill
			// ----------------------------------
			//
			gui_getInputField( propSkillSTEALING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_STEALING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_STEALING, newNumeric );
			//
			// process changes to: Stealth skill
			// ---------------------------------
			//
			gui_getInputField( propSkillSTEALTH, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_STEALTH );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_STEALTH, newNumeric );
			//
			// process changes to: Strength
			// ----------------------------
			//
			gui_getInputField( propStrength, newString );
			oldNumeric = chr_setProperty( serial, CP_STRENGHT, CP2_REAL);
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
			{
				chr_setProperty( serial, CP_STRENGHT, CP2_REAL, newNumeric );
				updateChar = 1;
			}
			//
			// process changes to: Swordmanship skill
			// --------------------------------------
			//
			gui_getInputField( propSkillSWORDSMANSHIP, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_SWORDSMANSHIP );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_SWORDSMANSHIP, newNumeric );
			//
			// process changes to: Tactics skill
			// ---------------------------------
			//
			gui_getInputField( propSkillTACTICS, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_TACTICS );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_TACTICS, newNumeric );
			//
			// process changes to: Tailoring skill
			// -----------------------------------
			//
			gui_getInputField( propSkillTAILORING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_TAILORING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_TAILORING, newNumeric );
			//
			// process changes to: Taming skill
			// --------------------------------
			//
			gui_getInputField( propSkillTAMING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_TAMING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_TAMING, newNumeric );
			//
			// process changes to: Taste identification skill
			// ----------------------------------------------
			//
			gui_getInputField( propSkillTASTEID, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_TASTEID );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_TASTEID, newNumeric );
			//
			// process changes to: Tinkering skill
			// -----------------------------------
			//
			gui_getInputField( propSkillTINKERING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_TINKERING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_TINKERING, newNumeric );
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if ( page == 15 )
		{
			//
			// process changes to: Title
			// -------------------------
			//
			gui_getInputField( propTitle, newString );
			trim( newString );
			chr_getProperty( serial, CP_STR_TITLE, _, oldString );
			if( strcmp( newString, oldString ) )
			{
				if( strlen( newString ) > 29 )
					newString{29} = 0;
				chr_setProperty( serial, CP_STR_TITLE, _, newString );
			}
			//
			// process changes to: Tracking skill
			// ----------------------------------
			//
			gui_getInputField( propSkillTRACKING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_TRACKING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_TRACKING, newNumeric );
			//
			// process changes to: Veterinary skill
			// ------------------------------------
			//
			gui_getInputField( propSkillVETERINARY, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_VETERINARY );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_VETERINARY, newNumeric );
			//
			// process changes to: Wander mode
			// -------------------------------
			//
			gui_getInputField( propWanderMode, newString );
			newStringLength = strlen( newString );
			oldNumeric = chr_getProperty( serial, CP_NPCWANDER, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric && newNumeric < 7 )
			{
				chr_setProperty( serial, CP_NPCWANDER, _, newNumeric )
			}
			//
			// process changes to: Old Wander mode
			// -----------------------------------
			//
			gui_getInputField( propOldWanderMode, newString );
			newStringLength = strlen( newString );
			oldNumeric = chr_getProperty( serial, CP_OLDNPCWANDER, _ );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric && newNumeric < 7 )
			{
				chr_setProperty( serial, CP_NPCWANDER, _, newNumeric )
			}
			//
			// process changes to: Wrestling skill
			// -----------------------------------
			//
			gui_getInputField( propSkillWRESTLING, newString );
			oldNumeric = chr_getProperty( serial, CP_SKILL, SK_WRESTLING );
			newNumeric = prop2Unsigned( newString, oldNumeric );
			if( newNumeric != oldNumeric )
				chr_setProperty( serial, CP_SKILL, SK_WRESTLING, newNumeric );
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		if( page > 15 )
		{
			//
			// Process user defined variables
			//
			new lastVar	= (page - 15) * 10;
			new firstVar	= lastVar - 9;
			new userVar = chr_firstLocalVar( serial );
			for( new varIndex = 1; varIndex < firstVar; ++varIndex )
				userVar = chr_nextLocalVar( serial, userVar );
			do
			{
				if( userVar != -1 )
				{
					if( gui_getInputField( propLocalVariables + userVar, newString ) )
					{
						if( chr_isaLocalVar( serial, userVar, VAR_TYPE_STRING ) )
						{
							chr_getLocalStrVar( serial, userVar, oldString );
							if( strcmp( newString, oldString ) )
								chr_setLocalStrVar( serial, userVar, newString );
						}
						else
						{
							trim( newString );
							oldNumeric = chr_getLocalIntVar( serial, userVar );
							if( isStrInt( newString ) )
								newNumeric = str2Int( newString );
							else
								if( isStrHex( newString ) )
									newNumeric = str2Hex( newString );
								else
									newNumeric = oldNumeric;
							if( newNumeric != oldNumeric )
								chr_setLocalIntVar( serial, userVar, newNumeric );
						}
					}
					userVar = chr_nextLocalVar( serial, userVar );
				}
			}
			while( ++firstVar <= lastVar )
			//
			// Finish
			//
			charPropsRespExit( updateChar, serial, pc, page, edit )
			return;
		}
		//
		// Failsafe Finish
		//
		charPropsRespExit( updateChar, serial, pc, 1, edit )
		return;
	}
}

static charPropsRespInit( const button, &edit, &page )
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

static charPropsRespExit( const updateChar, const charSerial, const pc, const page, const edit )
{
		//
		// Show alterations if necessary
		//
		if( updateChar )
			chr_teleport( charSerial );
		//
		// reset original stringmode
		//
		setStringMode( stringMode );
		charPropsPage( charSerial, pc, edit, page );
}

static charPropsPage( const clickedChar, const showToWhom, const edit, const page )
{
	rowDistance	= rowSpacing + rowHeight;
	col2X		= col1X + col1Len + colSpacing;
	col1XTxt	= col1X + 5;
	col2XTxt	= col2X + 5;

	gui_delete( GUI_CHARPROP );
	if( gui_create( GUI_CHARPROP, 0, 0, 1, 1, 1, clickedChar ) )
	{
		//
		// VARIABLES
		//
		new str[50];
		new str1[50];
		new int;
		//
		//	Calculate maximum number of pages
		//
		lastPage	= 15 + ( chr_countLocalVar( clickedChar ) / 10 ) + ( chr_countLocalVar( clickedChar ) % 10  > 0 ? 1 : 0);
		currentPageRow	= 1;
		//
		//	Background
		//
		gui_addPage( GUI_CHARPROP, 0 );
		if( edit )
		{
			gui_addResizeGump( GUI_CHARPROP, 0, 0, 5120, 360, 365 );
			gui_addTiledGump(  GUI_CHARPROP,  10,  335, 342, rowHeight, colBackGump, 0 );
			gui_addButton( GUI_CHARPROP,  15, 341, 1209, 1209, page  );
			gui_addText( GUI_CHARPROP,  35, 337, "Apply", 45);
			gui_addButton( GUI_CHARPROP, 335, 341, 1209, 1209, buttonCancel );
			gui_addText( GUI_CHARPROP,  285, 337, "Cancel", 45);
		}
		else
			gui_addResizeGump( GUI_CHARPROP, 0, 0, 5120, 360, 345 );
		//
		// 	Form Title
		//
		rowY = 10;
		gui_addTiledGump( GUI_CHARPROP,  10,  rowY, 342, rowHeight, colBackGump, 0 );
		gui_addText( GUI_CHARPROP, 50, rowY+2, "NoX-Wizard - Character Properties", 45);
		gui_addPage( GUI_CHARPROP, 1 );
		//
		// 	Character properties
		//
		if( page == 1 )
		{
			//<Luxor>
			if ( chr_getProperty( clickedChar, CP_NPC ) )
				addProperty( "Class", "Non player character" );
			else {
				sprintf( str, "%d", chr_getProperty( clickedChar, CP_ACCOUNT ) );
				addProperty( "PC Account", str );
			}
			//</Luxor>
			
			//
			addProperty( "All move ability", ((chr_getProperty( clickedChar, CP_PRIV2, _)&0x1) ? "True" : "False" ), 0, 0, ( edit ? propAllMove : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_ANATOMY ) );
			addProperty( "Anatomy", str, 0, 0, ( edit ? propSkillANATOMY : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_ALCHEMY ) );
			addProperty( "Alchemy", str, 0, 0, ( edit ? propSkillALCHEMY : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_ANIMALLORE ) );
			addProperty( "Animal lore", str, 0, 0, ( edit ? propSkillANIMALLORE : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_ARCHERY ) );
			addProperty( "Archery", str, 0, 0, ( edit ? propSkillARCHERY : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_ARMSLORE ) );
			addProperty( "Arms lore", str, 0, 0, ( edit ? propSkillARMSLORE : 0 ) );
			//
			addProperty( "Attack first", (chr_getProperty( clickedChar, CP_ATTACKFIRST, _ ) ? "True" : "False") );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_BEGGING ) );
			addProperty( "Begging", str, 0, 0, ( edit ? propSkillBEGGING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_BLACKSMITHING ) );
			addProperty( "Blacksmithing", str, 0, 0, ( edit ? propSkillBLACKSMITHING : 0 ) );
			//
		}
		if ( page == 2 )
		{
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_BOWCRAFT ) );
			addProperty( "Bowcrafting", str, 0, 0, ( edit ? propSkillBOWCRAFT : 0 ) );
			//
			sprintf( str, "%d", (chr_getProperty( clickedChar, CP_ID, 2 )<<8) + chr_getProperty( clickedChar, CP_ID, 1 ) );
			addProperty( "Body (current)", str, 0, 0, ( edit ? propBody : 0 ) );
			//
			sprintf( str, "%d", (chr_getProperty( clickedChar, CP_XID, 2 )<<8) + chr_getProperty( clickedChar, CP_XID, 1 ) );
			addProperty( "Body (old)", str );
			//
			addProperty( "Broadcast ability", (chr_canBroadcast( clickedChar ) ? "True" : "False"), 0, 0, ( edit ? propCanBroadcast : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_CAMPING ) );
			addProperty( "Camping", str, 0, 0, ( edit ? propSkillCAMPING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_CARPENTRY ) );
			addProperty( "Carpentry", str, 0, 0, ( edit ? propSkillCARPENTRY : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_CARTOGRAPHY ) );
			addProperty( "Cartography", str, 0, 0, ( edit ? propSkillCARTOGRAPHY : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_COMMANDLEVEL, _ ) );
			addProperty( "Command level", str, 0, 0, ( edit ? propCommandLevel : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_COOKING ) );
			addProperty( "Cooking", str, 0, 0, ( edit ? propSkillCOOKING : 0 ) );
			//
			addProperty( "Councillor", (chr_getProperty( clickedChar, CP_PRIV, _ )&0x80 ? "True" : "False"), 0, 0, ( edit ? propCnclrClearance : 0 ) );
			//
		}
		if ( page == 3 )
		{
			addProperty( "Criminal", (chr_isCriminal( clickedChar ) ? "True" : "False"), 0, 0, ( edit ? propCriminal : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_DEATHS, _) );
			addProperty( "Deaths", str);
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_DEF, _) );
			addProperty( "Defence", str, 0, 0, ( edit ? propDefence : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_DETECTINGHIDDEN ) );
			addProperty( "Detect hidden", str, 0, 0, ( edit ? propSkillDETECTINGHIDDEN : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_DEXTERITY, CP2_REAL ));
			addProperty( "Dexterity", str, 0, 0, ( edit ? propDexterity : 0 ) );
			//
			switch( chr_getProperty( clickedChar, CP_DIR, _ ) )
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
			//
			addProperty( "Dispellable", ( (chr_getProperty( clickedChar, CP_PRIV2, _)&0x20 ) ? "True" : "False" ), 0, 0, ( edit ? propDispellable : 0 ) );
			//
			addProperty( "Encumbered", ( chr_getProperty( clickedChar, CP_OVERWEIGHTED, _ ) ? "True" : "False" ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_ENTICEMENT ) );
			addProperty( "Enticement", str, 0, 0, ( edit ? propSkillENTICEMENT : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_EVALUATINGINTEL ) );
			addProperty( "Evaluate intelligence", str, 0, 0, ( edit ? propSkillEVALUATINGINTEL : 0 ) );
			//
		}
		if ( page == 4 )
		{
			chr_getEventHandler( clickedChar, EVENT_CHR_ONDEATH, str );
			addProperty( "Event death", str, 0, 0, ( edit ? propOnDeath : 0 ) );
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONWOUNDED, str );
			addProperty( "Event wounded", str, 0, 0, ( edit ? propOnWounded : 0 ) );
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONHIT, str );
			addProperty( "Event hit", str, 0, 0, ( edit ? propOnHit : 0 ) );
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONHITMISS, str );
			addProperty( "Event hitmiss", str, 0, 0, ( edit ? propOnHitMiss : 0 ) );
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONGETHIT, str );
			addProperty( "Event get hit", str, 0, 0, ( edit ? propOnGetHit : 0 ) );
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONREPUTATIONCHG, str );
			addProperty( "Event reputation change", str, 0, 0, ( edit ? propOnReputation : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONDISPEL, str );
			addProperty( "Event dispel", str, 0, 0, ( edit ? propOnDispel : 0 ) );
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONRESURRECT, str );
			addProperty( "Event resurrect", str, 0, 0, ( edit ? propOnResurrect : 0 ) );
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONFLAGCHG, str );
			addProperty( "Event flag change", str, 0, 0, ( edit ? propOnFlagChg : 0 ) );
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONWALK, str );
			addProperty( "Event walk", str, 0, 0, ( edit ? propOnWalk : 0 ));
			//
		}
		if ( page == 5 )
		{
			chr_getEventHandler( clickedChar, EVENT_CHR_ONADVANCESKILL, str );
			addProperty( "Event advance skill", str, 0, 0, ( edit ? propOnAdvanceSkill : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONADVANCESTAT, str );
			addProperty( "Event advance stat", str, 0, 0, ( edit ? propOnAdvanceStat : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONBEGINATTACK, str );
			addProperty( "Event begin attack", str, 0, 0, ( edit ? propOnBeginAttack : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONBEGINDEFENSE, str );
			addProperty( "Event begin defence", str, 0, 0, ( edit ? propOnBeginDefence : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONTRANSFER, str );
			addProperty( "Event transfer", str, 0, 0, ( edit ? propOnTransfer : 0 ) );
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONMULTIENTER, str );
			addProperty( "Event multi enter", str, 0, 0, ( edit ? propOnMultiEnter : 0 ) );
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONMULTILEAVE, str );
			addProperty( "Event multi leave", str, 0, 0, ( edit ? propOnMultiLeave : 0 ) );
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONSNOOPED, str );
			addProperty( "Event snooped", str, 0, 0, ( edit ? propOnSnooped : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONSTOLEN, str );
			addProperty( "Event stolen", str, 0, 0, ( edit ? propOnStolen : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONPOISONED, str );
			addProperty( "Event poisoned", str, 0, 0, ( edit ? propOnPoisoned : 0 ));
			//
		}
		if ( page == 6 )
		{
			chr_getEventHandler( clickedChar, EVENT_CHR_ONREGIONCHANGE, str );
			addProperty( "Event region change", str, 0, 0, ( edit ? propOnRegionChg : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONCASTSPELL, str );
			addProperty( "Event cast spell", str, 0, 0, ( edit ? propOnCastSpell : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONGETSKILLCAP, str );
			addProperty( "Event get skillcap", str, 0, 0, ( edit ? propOnGetSkillCap : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONGETSTATCAP, str );
			addProperty( "Event get statcap", str, 0, 0, ( edit ? propOnGetStatCap : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONBLOCK, str );
			addProperty( "Event blocked", str, 0, 0, ( edit ? propOnBlock : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONSTART, str );
			addProperty( "Event start", str, 0, 0, ( edit ? propOnStart : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONHEARTBEAT, str );
			addProperty( "Event heartbeat", str, 0, 0, ( edit ? propOnHeartBeat : 0 ) );
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONBREAKMEDITATION, str );
			addProperty( "Event break meditation", str, 0, 0, ( edit ? propOnBreakMeditat : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONCLICK, str );
			addProperty( "Event click", str, 0, 0, ( edit ? propOnClick : 0 ));
			//
			chr_getEventHandler( clickedChar, EVENT_CHR_ONMOUNT, str );
			addProperty( "Event mount", str, 0, 0, ( edit ? propOnMount : 0 ));
			//
		}
		if ( page == 7 )
		{
			chr_getEventHandler( clickedChar, EVENT_CHR_ONDISMOUNT, str );
			addProperty( "Event dismount", str, 0, 0, ( edit ? propOnDismount : 0 ));
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_FAME, _ ));
			addProperty( "Fame", str, 0, 0, ( edit ? propFame : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_FENCING ) );
			addProperty( "Fencing", str, 0, 0, ( edit ? propSkillFENCING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_FISHING ) );
			addProperty( "Fishing", str, 0, 0, ( edit ? propSkillFISHING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_FORENSICS ) );
			addProperty( "Forensics", str, 0, 0, ( edit ? propSkillFORENSICS : 0 ) );
			//
			addProperty( "Frozen", ( (chr_getProperty( clickedChar, CP_PRIV2, _)&0x2) ? "True" : "False" ), 0, 0, ( edit ? propFrozen : 0 ) );
			// TO DO: remove GM property, is handled by clearance prop
			addProperty( "Game master", (chr_isGM( clickedChar ) ? "True" : "False") );
			//
			addProperty( "Game master clearance", ( chr_getProperty( clickedChar, CP_PRIV, _)&0x1 ? "True" : "False" ), 0, 0, ( edit ? propGMClearance : 0 ) );
			//
			addProperty( "Game master is pageable", ( chr_getProperty( clickedChar, CP_PRIV, _)&0x20 ? "True" : "False" ), 0, 0, ( edit ? propGMPageable : 0 ));
			//
			addProperty( "Guarded", (chr_getProperty( clickedChar, CP_GUARDED, _ ) ? "True" : "False" ) );
			//
		}
		if ( page == 8 )
		{
			sprintf( str, "%d", chr_getGuildNumber( clickedChar ) );
			addProperty( "Guild", str );
			//
			chr_getGuildTitle( clickedChar, str );
			addProperty( "Guild title", str, 0, 1 );
			//
			addProperty( "Guild title shown", (chr_hasGuildToggle( clickedChar ) ? "True" : "False" ) );
			//
			addProperty( "Guild traitor", (chr_getProperty( clickedChar, CP_GUILDTRAITOR, _ ) ? "True" : "False" ) );
			//
			switch( chr_getGuildType( clickedChar ) )
			{
				case 0 : str = "Standard";
				case 1 : str = "Order";
				case 2 : str = "Chaos";
				default: str = "Unknown";
			}
			addProperty( "Guild type", str );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_HEALING ) );
			addProperty( "Healing", str, 0, 0, ( edit ? propSkillHEALING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_HERDING ) );
			addProperty( "Herding", str, 0, 0, ( edit ? propSkillHERDING : 0 ) );
			//
			if ( (chr_getProperty( clickedChar, CP_PRIV2, _)&0x8 ) )
				int = 3;
			else
				int = chr_getProperty( clickedChar, CP_HIDDEN, _);
			switch( int )
			{
				case 0 : str = "False";
				case 1 : str = "By skill";
				case 2 : str = "By spell";
				case 3 : str = "Permanent";
				default: str = "Unknown";
			}
			addProperty( "Hidden", str );
			//
			addProperty( "Hidden permanently", ((chr_getProperty( clickedChar, CP_PRIV2, _)&0x8) ? "True" : "False" ), 0, 0, ( edit ? propAlwaysHidden : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_HIDING ) );
			addProperty( "Hiding", str, 0, 0, ( edit ? propSkillHIDING : 0 ) );
			//
		}
		if ( page == 9 )
		{
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_STRENGHT, CP2_ACT ) );
			addProperty( "Hitpoints", str );
			//
			addProperty( "Houses iconized", ((chr_getProperty( clickedChar, CP_PRIV2, _)&0x4) ? "True" : "False" ), 0, 0, ( edit ? propHouseAsIcon : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_HUNGER, _ ));
			addProperty( "Hunger", str, 0, 0, ( edit ? propHunger : 0 ) );
			//
			addProperty( "Incognito", "");
			//
			addProperty( "Innocent", (chr_isInnocent( clickedChar ) ? "True" : "False") );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_INSCRIPTION ) );
			addProperty( "Inscription", str, 0, 0, ( edit ? propSkillINSCRIPTION : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_INTELLIGENCE, CP2_REAL ));
			addProperty( "Intelligence", str, 0, 0, ( edit ? propIntelligence : 0 ) );
			//
			addProperty( "Invulnerable", (chr_getProperty( clickedChar, CP_PRIV,_ )&0x04 ? "True" : "False"), 0, 0, ( edit ? propInvulnerable : 0 ));
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_ITEMID ) );
			addProperty( "Item identification", str, 0, 0, ( edit ? propSkillITEMID : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_KARMA, _ ));
			addProperty( "Karma", str, 0, 0, ( edit ? propKarma : 0 ) );
			//
		}
		if ( page == 10 )
		{
			sprintf( str, "%d %d %d",	chr_getProperty( clickedChar, CP_POSITION, CP2_X ),
							chr_getProperty( clickedChar, CP_POSITION, CP2_Y ),
							chr_getProperty( clickedChar, CP_POSITION, CP2_Z ));
			addProperty( "Location (current)", str, 0, 0, ( edit ? propLocation : 0 ) );
			//
			sprintf( str, "%d, %d, %d",	chr_getProperty( clickedChar, CP_OLDPOS, CP2_X ),
							chr_getProperty( clickedChar, CP_OLDPOS, CP2_Y ),
							chr_getProperty( clickedChar, CP_OLDPOS, CP2_Z ));
			addProperty( "Location (old)", str );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_LOCKPICKING ) );
			addProperty( "Lock picking", str, 0, 0, ( edit ? propSkillLOCKPICKING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_LUMBERJACKING ) );
			addProperty( "Lumberjacking", str, 0, 0, ( edit ? propSkillLUMBERJACKING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_MACEFIGHTING ) );
			addProperty( "Macefighting", str, 0, 0, ( edit ? propSkillMACEFIGHTING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_MAGERY ) );
			addProperty( "Magery", str, 0, 0, ( edit ? propSkillMAGERY : 0 ) );
			//
			addProperty( "Magic reflect ability", ((chr_getProperty( clickedChar, CP_PRIV2, _)&0x40) ? "True" : "False" ), 0, 0, ( edit ? propManaUnneeded : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_MAGICRESISTANCE ) );
			addProperty( "Magic resistance", str, 0, 0, ( edit ? propSkillMAGICRESISTANCE : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_INTELLIGENCE, CP2_ACT ));
			addProperty( "Mana", str );
			//
			addProperty( "Mana not needed", ((chr_getProperty( clickedChar, CP_PRIV2, _)&0x10) ? "True" : "False" ), 0, 0, ( edit ? propManaUnneeded : 0 ) );
			//
		}
		if ( page == 11)
		{
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_MEDITATION ) );
			addProperty( "Meditation", str, 0, 0, ( edit ? propSkillMEDITATION : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_MINING ) );
			addProperty( "Mining", str, 0, 0, ( edit ? propSkillMINING : 0 ) );
			//
			addProperty( "Mounted", (chr_getProperty( clickedChar, CP_ONHORSE, _) ? "True" : "False" ) );
			//
			addProperty( "Murderer", (chr_isMurderer( clickedChar ) ? "True" : "False") );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_KILLS, _) );
			addProperty( "Murders committed", str, 0, 0, ( edit ? propKills : 0 ) );
			//
			addProperty( "Murderrate timer", "not yet available" );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_MUSICIANSHIP ) );
			addProperty( "Musicianship", str, 0, 0, ( edit ? propSkillMUSICIANSHIP : 0 ) );
			//
			chr_getProperty( clickedChar, CP_STR_NAME, _, str );
			addProperty( "Name (current)", str, 0, 0, ( edit ? propName : 0 ) );
			//
			chr_getProperty( clickedChar, CP_STR_ORGNAME, _, str );
			addProperty( "Name (real)", str, 0, 1 );
			//
			int = chr_getProperty( clickedChar, CP_WEIGHT, _ ) - chr_getProperty( clickedChar, CP_STRENGHT, CP2_REAL )*4 + 30;
			if( int < 0 )
				int = 0;
			sprintf( str, "%d", int );
			addProperty( "Overweight", str );
			//
		}
		if ( page == 12 )
		{
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_OWNSERIAL2, _ ));
			addProperty( "Owner", str );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_PARRYING ) );
			addProperty( "Parrying", str, 0, 0, ( edit ? propSkillPARRYING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_PEACEMAKING ) );
			addProperty( "Peacemaking", str, 0, 0, ( edit ? propSkillPEACEMAKING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_POISONING ) );
			addProperty( "Poisoning", str, 0, 0, ( edit ? propSkillPOISONING : 0 ) );
			//
			addProperty( "Polymorphed", ( chr_getProperty( clickedChar, CP_POLYMORPH, _) ? "True" : "False" ) );
			//
			int = chr_getProperty( clickedChar, CP_POSTTYPE, _);
			switch( int )
			{
				case 0 : str = !"Local";
				case 1 : str = !"Regional";
				case 2 : str = !"Global";
				default: str = !"Unknown";
			}
			addProperty( "Post type", str );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_PROVOCATION ) );
			addProperty( "Provocation", str, 0, 0, ( edit ? propSkillPROVOCATION : 0 ) );
			//
			addProperty( "Reagents not needed", ((chr_getProperty( clickedChar, CP_PRIV2, _)&0x80) ? "True" : "False" ), 0, 0, ( edit ? propNoReagents : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_REMOVETRAPS ) );
			addProperty( "Remove traps", str, 0, 0, ( edit ? propSkillREMOVETRAPS : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SERIAL, _ ) );
			addProperty( "Serial", str );
			//
		}
		if ( page == 13 )
		{
			addProperty( "Serial display", (chr_getProperty( clickedChar, CP_PRIV,_ )&0x08 ? "True" : "False"), 0, 0, ( edit ? propShowSerials : 0 ));
			//
			addProperty( "Script", "n/a" );
			//
			addProperty("Shopkeeper", ( chr_getProperty( clickedChar, CP_SHOPKEEPER, _) ? "True" : "False" ));
			//
			addProperty( "Skill title off", ((chr_getProperty( clickedChar, CP_PRIV, _)&0x10) ? "True" : "False" ), 0, 0, ( edit ? propShowSkill : 0 ) );
			//
			sprintf( str, "%d", chr_getDualByteProperty( clickedChar, CP_SKIN ) );
			addProperty( "Skin (current)", str, 0, 0, ( edit ? propSkin : 0 ) );
			//
			sprintf( str, "%d", chr_getDualByteProperty( clickedChar, CP_XSKIN ) );
			addProperty( "Skin (old)", str, 0, 0, ( edit ? propSkinOld : 0 ) );
			//
			addProperty( "Snoop ability", (chr_getProperty( clickedChar, CP_PRIV, _ )&0x40 ? "True" : "False"), 0, 0, ( edit ? propSnoopAbility : 0 ));
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_SNOOPING ) );
			addProperty( "Snooping", str, 0, 0, ( edit ? propSkillSNOOPING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_SPIRITSPEAK ) );
			addProperty( "Spiritspeak", str, 0, 0, ( edit ? propSkillSPIRITSPEAK : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_DEXTERITY, CP2_ACT ));
			addProperty( "Stamina", str );
			//
		}
		if ( page == 14 )
		{
			addProperty( "Stat gain today", "n/a (yet)" );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_STEALING ) );
			addProperty( "Stealing", str, 0, 0, ( edit ? propSkillSTEALING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_STEALTH ) );
			addProperty( "Stealth", str, 0, 0, ( edit ? propSkillSTEALTH : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_STRENGHT, CP2_REAL ) );
			addProperty( "Strength", str, 0, 0, ( edit ? propStrength : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_SWORDSMANSHIP ) );
			addProperty( "Swordmanship", str, 0, 0, ( edit ? propSkillSWORDSMANSHIP : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_TACTICS ) );
			addProperty( "Tactics", str, 0, 0, ( edit ? propSkillTACTICS : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_TAILORING ) );
			addProperty( "Tailoring", str, 0, 0, ( edit ? propSkillTAILORING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_TAMING ) );
			addProperty( "Taming", str, 0, 0, ( edit ? propSkillTAMING : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_TASTEID ) );
			addProperty( "Taste identification", str, 0, 0, ( edit ? propSkillTASTEID : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_TINKERING ) );
			addProperty( "Tinkering", str, 0, 0, ( edit ? propSkillTINKERING : 0 ) );
			//
		}
		if ( page == 15 )
		{
			chr_getProperty( clickedChar, CP_STR_TITLE, _, str );
			addProperty( "Title", str, 0, 0, ( edit ? propTitle : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_TRACKING ) );
			addProperty( "Tracking", str, 0, 0, ( edit ? propSkillTRACKING : 0 ) );
			//
			addProperty( "Trained", ( chr_getProperty( clickedChar, CP_ISBEINGTRAINING, _) ? "True" : "False" ) );
			//
			addProperty( "Trainer", ( chr_getProperty( clickedChar, CP_CANTRAIN, _) ? "True" : "False" ) );
			//
			addProperty( "Unicode", ( chr_getProperty( clickedChar, CP_UNICODE, _) ? "True" : "False" ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_VETERINARY ) );
			addProperty( "Veterinary", str, 0, 0, ( edit ? propSkillVETERINARY : 0 ) );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_NPCWANDER, _ ) );
			addProperty( "Wander mode", str, 0, 0, ( edit ? propWanderMode : 0 )  );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_OLDNPCWANDER, _ ) );
			addProperty( "Wander mode (old)", str, 0, 0, ( edit ? propOldWanderMode : 0 )  );
			//
			sprintf( str, "%d/%d", chr_getProperty(clickedChar, CP_WEIGHT, _), chr_getProperty(clickedChar, CP_STRENGHT, CP2_REAL )*4+30 );
			addProperty( "Weight", str );
			//
			sprintf( str, "%d", chr_getProperty( clickedChar, CP_SKILL, SK_WRESTLING ) );
			addProperty( "Wrestling", str, 0, 0, ( edit ? propSkillWRESTLING : 0 ) );
		}
		if( page > 15 )
		{
			new lastVar	= (page - 15) * 10;
			new firstVar	= lastVar - 9;
			new userVar = chr_firstLocalVar( clickedChar );
			for( new varIndex = 1; varIndex < firstVar; ++varIndex )
				userVar = chr_nextLocalVar( clickedChar, userVar );
			do
			{
				if( userVar != -1 )
				{
					if( chr_isaLocalVar( clickedChar, userVar, VAR_TYPE_STRING ) )
					{
						sprintf( str, "Local str var %d", userVar );
						chr_getLocalStrVar( clickedChar, userVar, str1 )
					}
					else
					{
						sprintf( str, "Local int var %d", userVar );
						sprintf( str1, "%d", chr_getLocalIntVar( clickedChar, userVar ) );
					}
					addProperty( str, str1, 0, 0, ( edit ? propLocalVariables + userVar : 0 ) );
					userVar = chr_nextLocalVar( clickedChar, userVar );
				}
			}
			while( ++firstVar <= lastVar )
		}
		addToolBars( page, edit );
		//
		gui_show( GUI_CHARPROP, showToWhom );
		gui_delete( GUI_CHARPROP );
	}
}

static addProperty( const colVal1[], colVal2[], const cropCol1 = 0, const cropCol2 = 0, const editField = 0 )
{
	rowY += rowDistance;
	gui_addTiledGump( GUI_CHARPROP, col1X,   rowY,   col1Len, rowHeight, colBackGump, 0 );
	if ( cropCol1 )
		gui_addCroppedText( GUI_CHARPROP, col1XTxt, rowY+2, col1Len, rowHeight, colVal1, 45);
	else
		gui_addText( GUI_CHARPROP, col1XTxt,rowY+2, colVal1, 45);
	gui_addTiledGump( GUI_CHARPROP, col2X,   rowY,   col2Len, rowHeight, colBackGump, 0 );
	if( editField )
		gui_addInputField( GUI_CHARPROP, col2XTxt, rowY+2, col2Len, rowHeight, editField, colVal2, 11);
	else
		if( cropCol2 )
			gui_addCroppedText( GUI_CHARPROP, col2XTxt,rowY+2, col2Len, rowHeight, colVal2, 45);
		else
			gui_addText( GUI_CHARPROP, col2XTxt,rowY+2, colVal2, 45);
}

static addToolBars( const page, const edit )
{
	new pagebuttonOffset = ( edit ? lastPage * 2 : lastPage );

	rowY = 10 + rowDistance * 11;
	if( page != 1 )
	{
		gui_addButton( GUI_CHARPROP, col1XTxt,  rowY+2, 1210, 1210, (1 + pagebuttonOffset) );
		gui_addButton( GUI_CHARPROP,  40,  rowY+2, 1210, 1210, ( page == 1 ? (1 + pagebuttonOffset) : (pagebuttonOffset + page - 1) ) );
	}
	if( page != lastPage )
	{
		gui_addButton( GUI_CHARPROP, 310,  rowY+2, 1210, 1210, ( page == lastPage ? (pagebuttonOffset + lastPage) : (pagebuttonOffset + page + 1) ) );
		gui_addButton( GUI_CHARPROP, 335,  rowY+2, 1210, 1210, (pagebuttonOffset + lastPage) );
	}
	gui_addTiledGump(  GUI_CHARPROP,  col1X,  rowY, 342, rowHeight, colBackGump, 0 );
	gui_addText(	   GUI_CHARPROP,  col1XTxt, rowY+2, "|<", 45);
	gui_addText(	   GUI_CHARPROP,  40, rowY+2, "<", 45);
	gui_addText(	   GUI_CHARPROP,  312, rowY+2, ">", 45);
	gui_addText(	   GUI_CHARPROP,  337, rowY+2, ">|", 45);
}

