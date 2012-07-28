#include "acr_spells_i"
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
	object oPC = GetLastUsedBy();
	
	// Is the player otherwise immune to drowning?
	if ( GetHasSpellEffect( SPELL_WATER_BREATHING, oPC ) ) {
		SendMessageToPC( oPC, "Has " + IntToString( SPELL_WATER_BREATHING ) + " effect." );
	} else {
		SendMessageToPC( oPC, "Does not have " + IntToString( SPELL_WATER_BREATHING ) + " effect." );
	}
}