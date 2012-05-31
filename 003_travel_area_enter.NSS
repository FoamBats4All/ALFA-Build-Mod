// 10.23.2009 - AcadiusLost; added exception for relogging PCs.
//  3.28.2010 - TestAndSet fix -AL

#include "acr_area_i" 
#include "dmfi_inc_tool"

const int TRAVEL_SPEED_DECREASE = 85;
const float TRAVEL_MODEL_SCALE = 0.2;
	 
void main ()  {
	// Get entering PC.
	object oEnterer = GetEnteringObject();

	// Build general travel effects.
	effect eSlow = SupernaturalEffect( EffectMovementSpeedDecrease( TRAVEL_SPEED_DECREASE ) );
	effect eShrink = SupernaturalEffect( EffectSetScale( TRAVEL_MODEL_SCALE ) );
	effect eTravelEffect = EffectLinkEffects( eSlow, eShrink ); 
	eTravelEffect = EffectLinkEffects( eTravelEffect, SupernaturalEffect( EffectCutsceneGhost() ) );
	
	// Apply travel effects to PCs.
	effect eTest = GetFirstEffect( oEnterer );
	if ( ( GetIsPC( oEnterer ) && !GetIsDM( oEnterer ) ) ) {
		// Remove previous area-applied effects.
		while ( GetIsEffectValid( eTest ) ) {
			if ( GetEffectCreator( eTest ) == OBJECT_SELF ) {
				SendMessageToAllDMs( "Relogging PC: Removing eTest from " + GetName( oEnterer ) );
				RemoveEffect( oEnterer, eTest ); 
			} 
			eTest = GetNextEffect( oEnterer ); 
		}
		
		// Apply travel effects.
		AssignCommand( OBJECT_SELF, ApplyEffectToObject( DURATION_TYPE_PERMANENT, eTravelEffect, oEnterer ) ); 
		
		// Display the DMFI follow cancel widget.
		DisplayGuiScreen( oEnterer, SCREEN_DMFI_FOLLOWOFF, FALSE, "dmfifollowoff.xml" );
	} 
	
	// Build follower travel effects.
	effect eFollowerEffect = EffectVisualEffect( VFX_DUR_CUTSCENE_INVISIBILITY );
	
	// Apply follower effects.
	object oPartyLeader = GetFactionLeader( oEnterer );
	if ( ( oEnterer != oPartyLeader ) && ( !GetIsDMPossessed( oEnterer ) ) ) {
		DelayCommand( 3.0, SetCommandable( FALSE, oEnterer ) );
		DelayCommand( 5.0, AssignCommand( oEnterer, ActionForceFollowObject( oPartyLeader, 0.5, 0 ) ) );
		AssignCommand( OBJECT_SELF, ApplyEffectToObject( DURATION_TYPE_PERMANENT, eFollowerEffect, oEnterer ) );
	}
	
	// Hook ACR's area exit event.
	ACR_AreaOnClientEnter();
	
	// Show enter message.
	SendMessageToPC(oEnterer, "You have entered travel area: " + GetName( OBJECT_SELF ) ); 
}