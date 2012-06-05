// Detect Poison
// Created for ALFA by FoamBats4All 2012-05-30

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "acr_spells_i"

void main() {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell.
    if ( !X2PreSpellCastCode() ) return;
	
	// Get the caster and location of the target.
	object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
	
	// Get duration and limit.
	float fDuration = ACR_GetSpellDuration( oCaster, ACR_DURATION_TYPE_PER_CL, ACR_DURATION_2H );
	SendMessageToPC( oCaster, "Duration: " + FloatToString( fDuration ) );
	
	// Apply the spell effect.
	effect eVFX = EffectVisualEffect( VFX_HIT_DROWN );
	effect eSelfImmunity = EffectSpellImmunity( SPELL_WATER_BREATHING );
	effect eWaterBreathing = EffectLinkEffects( eVFX, eSelfImmunity );
	ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eWaterBreathing, oTarget, fDuration );
}