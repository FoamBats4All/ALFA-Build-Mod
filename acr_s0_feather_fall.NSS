// Detect Poison
// Created for ALFA by FoamBats4All 2012-05-30

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "acr_spells_i"

void main() {
	WriteTimestampedLogEntry( "acr_s0_feather_fall -- State 001" );
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell.
    if ( !X2PreSpellCastCode() ) return;
	WriteTimestampedLogEntry( "acr_s0_feather_fall -- State 002" );
	
	// Get the caster and location of the target.
	object oCaster = GetLastSpellCaster();
    location lLocal = GetSpellTargetLocation();
	
	// Get duration and limit.
	float fDuration = ACR_GetSpellDuration( oCaster, ACR_DURATION_TYPE_PER_CL, ACR_DURATION_1R );
	int nMaxTargets = GetCasterLevel( oCaster );
	WriteTimestampedLogEntry( "Caster: " + GetName( oCaster ) + " [" + IntToString(nMaxTargets) + "]" );
	
	// Loop through all in the field of effect.
	WriteTimestampedLogEntry( "acr_s0_feather_fall -- State 003" );
	int nNumTargetsUsed = 0;
	object oTarget = GetFirstObjectInShape( SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLocal, FALSE, OBJECT_TYPE_CREATURE );
	while ( nNumTargetsUsed < nMaxTargets && GetIsObjectValid( oTarget ) ) {
		WriteTimestampedLogEntry( "acr_s0_feather_fall -- State 003-s" );
		// Send them a message.
		SendMessageToPC( oTarget, "<C=lightblue>You are now under the effects of <i>Feather Fall</i>.</C>" );
		ApplyEffectToObject( DURATION_TYPE_TEMPORARY, EffectVisualEffect( VFX_DUR_SPELL_EAGLE_SPLENDOR ), oTarget, fDuration );
		DelayCommand( fDuration, SendMessageToPC( oTarget, "<C=lightblue><i>Feather Fall</i> has worn off.</C>" ) );
	
		// Next object.
		oTarget = GetNextObjectInShape( SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLocal, FALSE, OBJECT_TYPE_CREATURE );
		nNumTargetsUsed++;
	}
	WriteTimestampedLogEntry( "acr_s0_feather_fall -- State 004" );
}