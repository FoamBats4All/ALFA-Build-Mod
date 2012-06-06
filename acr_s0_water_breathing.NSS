// Water Breathing
// Created for ALFA by FoamBats4All 2012-05-30

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "acr_spells_i"

const float WATER_BREATHING_RADIUS = RADIUS_SIZE_SMALL;

void _ApplyWaterBreathing( object oTarget, float fDuration ) {
	// Signal event.
	SignalEvent( oTarget, EventSpellCastAt( oCaster, GetSpellId(), FALSE ) );
	
	// Apply the spell effect.
	effect eWaterBreathing = EffectLinkEffects( EffectSpellImmunity( SPELL_DROWN ), EffectSpellImmunity( SPELL_MASS_DROWN ) );
	ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eWaterBreathing, oTarget, fDuration );
	
	// Establish warning.
	WarnWhenSpellExpires( oTarget, GetSpellId(), "<C=lightblue><i>Water Breathing</i> has expired.</C>", fDuration );
}

void main() {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell.
    if ( !X2PreSpellCastCode() ) return;
	
	// Get the caster and location of the target.
	object oCaster = OBJECT_SELF;
	object oTarget = GetSpellTargetObject();
	object oLocation = GetSpellTargetLocation();
	
	// DEBUG
	SendMessageToPC( oCaster, "acr_s0_water_breathing v1.0.1" );
	
	// Get duration limit.
	float fDuration = ACR_GetSpellDuration( oCaster, ACR_DURATION_TYPE_PER_CL, ACR_DURATION_2H );
	
	// Do we have a target that isn't the caster? Focus only on them.
	if ( GetIsObjectValid( oTarget ) && oTarget != oCaster ) {
		_ApplyWaterBreathing( oTarget, fDuration );
	} else {
		// Otherwise get the number of targets to affect.
		int nTargetCount = 0;
		oTarget = GetFirstObjectInShape( SHAPE_SPHERE, WATER_BREATHING_RADIUS, lLocal, FALSE, OBJECT_TYPE_CREATURE );
		while ( GetIsObjectValid( oTarget ) ) {
			nTargetCount++;
			oTarget = GetNextObjectInShape( SHAPE_SPHERE, WATER_BREATHING_RADIUS, lLocal, FALSE, OBJECT_TYPE_CREATURE );
		}
		
		// Apply effect to all in area.
		fDuration = fDuration / nTargetCount;
		oTarget = GetFirstObjectInShape( SHAPE_SPHERE, WATER_BREATHING_RADIUS, lLocal, FALSE, OBJECT_TYPE_CREATURE );
		while ( GetIsObjectValid( oTarget ) ) {
			_ApplyWaterBreathing( oTarget, fDuration );
			oTarget = GetNextObjectInShape( SHAPE_SPHERE, WATER_BREATHING_RADIUS, lLocal, FALSE, OBJECT_TYPE_CREATURE );
		}
	}
}
