
public party_invite( party, const leader, const candidate )
{
	if( party==INVALID ) {
		party = party_create( leader );
	}

	if ( !party_isCandidate( party, candidate ) )
		party_addCandidate( party, leader, candidate );

	chr_message( leader, _, "You have invited them to join the party." );

	new name[150];
	chr_getProperty( leader, CP_STR_NAME, _, name );
	chr_message( candidate, _, "%s : You are invited to join the party. Type /accept to join or /decline to decline the offer.", name );
	
}

public party_onAddMember( const chr )
{
	new chr_party = chr_getProperty( chr, CP_PARTY );

	if( chr_party!=INVALID ) {
		if( !party_isLeader( chr_party, chr )) {	
			chr_message( chr, _, "You may only add members to the party if you are the leader." );
			return;
		}
		else if( party_getProperty( chr_party, PP_MEMBERS ) + party_getProperty( chr_party, PP_CANDIDATES ) >=10 ) {
			chr_message( chr, _, "You may only have 10 in your party (this includes candidates)." );
			return;
		}
	}

	target_create( chr, _, _, _, "handle_party_onAddM" );
	chr_message( chr, _, "Who would you like to add to your party?" );

}

public handle_party_onAddM( const target, const chr, const obj, const x, const y, const z, const model, const param1 )
{
	
	new chr_party = chr_getProperty( chr, CP_PARTY );
	new obj_party = chr_getProperty( obj, CP_PARTY );
		
	if( !isChar( obj ) ) {
		chr_message( chr, _, "You may only add living things to your party!" );
		return;
	}
	if( chr==obj ) {
		chr_message( chr, _, "You cannot add yourself to a party." );
		return;
	}
	if( !chr_isHuman( obj ) ) {
		 chr_message( chr, _, "Nay, I would rather stay here and watch a nail rust." );
		 return;
	}
	if( chr_party!=INVALID ) {
		if( !party_isLeader( chr_party, chr ) ) {	
			chr_message( chr, _, "You may only add members to the party if you are the leader." );
			return;
		}
		else if( party_getProperty( chr_party, PP_MEMBERS ) + party_getProperty( chr_party, PP_CANDIDATES ) >=10 ) {
			chr_message( chr, _, "You may only have 10 in your party (this includes candidates)." );
			return;
		}
	}
	
	if( chr_isNpc( obj ) ) {
		chr_message( chr, _, "The creature ignores your offer." );
		return;
	}
	if( chr_party!=INVALID && chr_party==obj_party ) {
		chr_message( chr, _, "This person is already in your party!" );
		return;
	}
	if( obj_party!=INVALID ) {
		chr_message( chr, _, "This person is already in a party!" );
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
		sysmessage( chr, _, "Select the one to remove to the party.." );
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
		chr_message( chr, _, "You're not in a party!" );
	}
	else if( chr==kicked ) {
		party_delMember( chr_party, chr );
	}
	else {
		new kicked_party = chr_getProperty( kicked, CP_PARTY );
		if( !party_isLeader( kicked_party, chr ))
			chr_message( chr, _, "You may only remove yourself from a party if you are not the leader." );
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
		chr_message( chr, _, "You're not in a party!" );
	} else if( loot ) {
		chr_message( chr, _, "You have chosen to allow your party to loot your corpse." );
		party_setProperty( chr_party, PP_CANLOOT, chr, loot );
	}
	else {
		chr_message( chr, _, "You have chosen to prevent your party from looting your corpse." );
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
	party_broadcast( party, _, "%s  : joined the party.", name );
	
	party_addMember( party, chr );
	chr_message( chr, _, "You have been added to the party." );
	
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
	party_broadcast( party, _, "%s  : Does not wish to join the party.", name );
	
	chr_message( chr, _, "You notify them that you do not wish to join the party." );
	
	party_delCandidate( party, chr );
	
}