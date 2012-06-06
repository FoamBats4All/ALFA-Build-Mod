#include "acr_resting_i"

void main()
{
	object oPC = GetLastUsedBy();
	
	// Is the player otherwise immune to drowning?
	if ( GetHasSpellEffect( SPELL_MAGE_ARMOR, oPC ) ) {
		SendMessageToPC( oPC, "Has SPELL_MAGE_ARMOR effect." );
	} else {
		SendMessageToPC( oPC, "Does not have SPELL_MAGE_ARMOR effect." );
	}
}