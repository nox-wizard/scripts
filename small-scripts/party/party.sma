
public party_invite( party, const leader, const candidate )
{
	if( party==INVALID ) {
		party = party_create( leader );
	}

	if ( !party_isCandidate( party, candidate ) )
		party_addCandidate( party, leader, candidate );

	chr_message( leader, _, msg_api_partyDef[0] );

	new name[150];
	chr_getProperty( leader, CP_STR_NAME, _, name );
	chr_message( candidate, _, msg_api_partyDef[1], name );
	
}

public party_onAddMember( const chr )
{
	new chr_party = chr_getProperty( chr, CP_PARTY );

	if( chr_party!=INVALID ) {
		if( !party_isLeader( chr_party, chr )) {	
			chr_message( chr, _, msg_api_partyDef[2] );
			return;
		}
		else if( party_getProperty( chr_party, PP_MEMBERS ) + party_getProperty( chr_party, PP_CANDIDATES ) >=10 ) {
			chr_message( chr, _, msg_api_partyDef[3] );
			return;
		}
	}

	target_create( chr, _, _, _, "handle_party_onAddM" );
	chr_message( chr, _, msg_api_partyDef[4] );

}

public handle_party_onAddM( const target, const chr, const obj, const x, const y, const z, const model, const param1 )
{
	
	new chr_party = chr_getProperty( chr, CP_PARTY );
	new obj_party = chr_getProperty( obj, CP_PARTY );
		
	if( !isChar( obj ) ) {
		chr_message( chr, _, msg_api_partyDef[5] );
		return;
	}
	if( chr==obj ) {
		chr_message( chr, _, msg_api_partyDef[6] );
		return;
	}
	if( !chr_isHuman( obj ) ) {
		 chr_message( chr, _, msg_api_partyDef[7] );
		 return;
	}
	if( chr_party!=INVALID ) {
		if( !party_isLeader( chr_party, chr ) ) {	
			chr_message( chr, _, msg_api_partyDef[2] );
			return;
		}
		else if( party_getProperty( chr_party, PP_MEMBERS ) + party_getProperty( chr_party, PP_CANDIDATES ) >=10 ) {
			chr_message( chr, _, msg_api_partyDef[3] );
			return;
		}
	}
	
	if( chr_isNpc( obj ) ) {
		chr_message( chr, _, msg_api_partyDef[10] );
		return;
	}
	if( chr_party!=INVALID && chr_party==obj_party ) {
		chr_message( chr, _, msg_api_partyDef[11] );
		return;
	}
	if( obj_party!=INVALID ) {
		chr_message( chr, _, msg_api_partyDef[12] );
		return;
	}
	
	party_invite( chr_party, chr, obj );
	
}

/*!
\brief Player request remove of a member
\author Endymion
\param chr the player who request remove
*/
public party_onDelMember( const chr, const kicked )
{
	if( kicked==INVALID ) {
		target_create( chr, _, _, _, "handle_party_onDelM" );
		chr_message( chr, _, msg_api_partyDef[13] );
	}
	else 
		handle_party_onDelM( INVALID, chr, kicked );
		
}

public handle_party_onDelM( const target, const chr, const kicked )
{
	if( !isChar( kicked ) )
		return;
	
	new chr_party = chr_getProperty( chr, CP_PARTY );
	
	if( chr_party==INVALID ) {
		chr_message( chr, _, msg_api_partyDef[14] );
	}
	else if( chr==kicked ) {
		party_delMember( chr_party, chr );
	}
	else {
		new kicked_party = chr_getProperty( kicked, CP_PARTY );
		if( !party_isLeader( kicked_party, chr ))
			chr_message( chr, _, msg_api_partyDef[15] );
		else
			party_kickMember( chr_party, kicked );
	}
}

/*!
\brief Player request add of new friend
\author Endymion
\param chr the player who request add
\note can be also request of new party creation
*/
public party_onLootMode( const chr, const loot )
{
	new chr_party = chr_getProperty( chr, CP_PARTY );
	
	if( chr_party==INVALID ) {
		chr_message( chr, _, msg_api_partyDef[14] );
	} else if( loot ) {
		chr_message( chr, _, msg_api_partyDef[16] );
		party_setProperty( chr_party, PP_CANLOOT, chr, loot );
	}
	else {
		chr_message( chr, _, msg_api_partyDef[17] );
		party_setProperty( chr_party, PP_CANLOOT, chr, loot );
	}
}

public party_onAccept( const chr, const leader  )
{
	new party = chr_getProperty( leader, CP_PARTY );
	if( party==INVALID )
		return;
		
	if( !party_isCandidate( party, chr ) )
		return;
		
	party_delCandidate( party, chr );
	
	
	new name[150];
	chr_getProperty( chr, CP_STR_NAME, _, name );
	party_broadcast( party, _, msg_api_partyDef[18], name );
	
	party_addMember( party, chr );
	chr_message( chr, _, msg_api_partyDef[19] );
	
}

public party_onDecline( const chr, const leader  )
{
	new party = chr_getProperty( leader, CP_PARTY );
	if( party==INVALID )
		return;
		
	if( !party_isCandidate( party, chr ) )
		return;
		
	new name[150];
	chr_getProperty( chr, CP_STR_NAME, _, name );
	party_broadcast( party, _, msg_api_partyDef[20], name );
	
	chr_message( chr, _, msg_api_partyDef[21] );
	
	party_delCandidate( party, chr );
	
}