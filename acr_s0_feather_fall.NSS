// Detect Poison
// Created for ALFA by FoamBats4All 2012-05-30

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "acr_spells_i"

const string ACR_FEATHER_FALL = "ACR_FEATHER_FALL";

void main() {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell.
    if ( !X2PreSpellCastCode() ) return;
	
	// Get the caster and location of the target.
	object oCaster = OBJECT_SELF;
    location lLocal = GetSpellTargetLocation();
	
	// Get duration and limit.
	float fDuration = ACR_GetSpellDuration( oCaster, ACR_DURATION_TYPE_PER_CL, ACR_DURATION_1R );
	int nMaxTargets = GetCasterLevel( oCaster );
	
	// Loop through all in the field of effect.
	int nNumTargetsUsed = 0;
	object oTarget = GetFirstObjectInShape( SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLocal, FALSE, OBJECT_TYPE_CREATURE );
	while ( nNumTargetsUsed < nMaxTargets && GetIsObjectValid( oTarget ) ) {
		// Already under the effect of feather fall?
		if ( GetLocalInt( oTarget, ACR_FEATHER_FALL ) == TRUE ) {
			oTarget = GetNextObjectInShape( SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLocal, FALSE, OBJECT_TYPE_CREATURE );
			continue;
		}
	
		// Buff.
		ApplyEffectToObject( DURATION_TYPE_TEMPORARY, EffectVisualEffect( VFX_DUR_SPELL_EAGLE_SPLENDOR ), oTarget, fDuration );
	
		// Next object.
		oTarget = GetNextObjectInShape( SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLocal, FALSE, OBJECT_TYPE_CREATURE );
		nNumTargetsUsed++;
	}
}