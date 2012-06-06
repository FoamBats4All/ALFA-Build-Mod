#include "acr_resting_i"

void main()
{
	object oPC = GetLastUsedBy();
	
	
	// Is the player otherwise immune to drowning?
	if ( GetHasSpellEffect( 4013, oPC ) ) {
		SendMessageToPC( oPC, "Has 4013 effect." );
	} else {
		SendMessageToPC( oPC, "Does not have 4013 effect." );
	}
}