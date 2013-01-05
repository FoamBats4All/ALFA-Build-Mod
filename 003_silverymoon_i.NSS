////////////////////////////////////////////////////////////////////////////////
//
//  System Name : TSM Silverymoon Include File
//     Filename : 003_silverymoon_i.nss
//      Version : 1.0
//         Date : 2013-01-01
//       Author : FoamBats4All
//
//  Local Variable Prefix: 300_sm
//
//  = Dependencies =
//  None
//
//  = Description =
//  This script handles various function related to Silverymoon and its wards.
//
//  = Revision History =
//  2013-01-01  FoamBats4All    Inception.
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

string SM_WARD_ENABLED_VAR = "003_SM_WARDED";
string SM_WARD_CREATOR_VAR = "003_SM_WARDCREATOR";


////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//!! Silverymoon ward effect.
effect EffectSilverymoonWards();

//!! Returns true if the target is affected by Silverymoon's wards.
int GetIsWardedBySilverymoon( object oPC );

//!! Apply Silverymoon wards.
int ApplySilverymoonWards( object oPC );

//!! Remove Silverymoon wards.
int RemoveSilverymoonWards( object oPC );


////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

effect EffectSilverymoonWards() {
	// Effect #1: Immunity to mind effects.
	effect eImmunityMindSpells = EffectImmunity( IMMUNITY_TYPE_MIND_SPELLS );
	eImmunityMindSpells = SupernaturalEffect( eImmunityMindSpells );
	
	// Effect #2: +2 to all saving throws against evil.
	effect eSavingThrowIncreased = EffectSavingThrowIncrease( SAVING_THROW_ALL, 2, SAVING_THROW_TYPE_EVIL, FALSE );
	eSavingThrowIncreased = SupernaturalEffect( eSavingThrowIncreased );
	
	// Effect #3: +2 deflection AC.
	effect eACIncreased = EffectACIncrease( 2, AC_DEFLECTION_BONUS, DAMAGE_TYPE_ALL );
	eACIncreased = SupernaturalEffect( eACIncreased );
	
	// Effect #4: Immunity to death magic.
	effect eImmunityDeathMagic = EffectImmunity( IMMUNITY_TYPE_DEATH );
	eImmunityDeathMagic = SupernaturalEffect( eImmunityDeathMagic );
	
	// Effect #5: Immunity to negative energy.
	effect eDMGImmunityIncreasedNegative = EffectDamageImmunityIncrease( DAMAGE_TYPE_NEGATIVE, 999 );
	eDMGImmunityIncreasedNegative = SupernaturalEffect( eDMGImmunityIncreasedNegative );
	
	// Effect #6: Immunity to negative level.
	effect eImmunityNegativeLevel = EffectImmunity( IMMUNITY_TYPE_NEGATIVE_LEVEL );
	eImmunityNegativeLevel = SupernaturalEffect( eImmunityNegativeLevel );
	
	// Effect #7: Immunity to ability decrease.
	effect eImmunityAbilityDecrease = EffectImmunity( IMMUNITY_TYPE_ABILITY_DECREASE );
	eImmunityAbilityDecrease = SupernaturalEffect( eImmunityAbilityDecrease );

	// Build our main effect.
	effect eSMWards = EffectLinkEffects( eSavingThrowIncreased, eImmunityMindSpells );
	eSMWards = EffectLinkEffects( eACIncreased, eSMWards );
	eSMWards = EffectLinkEffects( eImmunityDeathMagic, eSMWards );
	eSMWards = EffectLinkEffects( eDMGImmunityIncreasedNegative, eSMWards );
	eSMWards = EffectLinkEffects( eImmunityNegativeLevel, eSMWards );
	eSMWards = EffectLinkEffects( eImmunityAbilityDecrease, eSMWards );
	
	// And return it.
	return eSMWards;
}


int GetIsWardedBySilverymoon( object oPC ) {
	return ( GetLocalInt( oPC, SM_WARD_ENABLED_VAR ) == 1 );
}


int ApplySilverymoonWards( object oPC ) {
	// Abort if they are already warded.
	if ( GetIsWardedBySilverymoon( oPC ) ) return FALSE;
	
	// Get our applying area.
	object oArea = GetArea( oPC );
	
	// Apply the effects.
	effect eWard = EffectSilverymoonWards();
	AssignCommand( oArea, ApplyEffectToObject( DURATION_TYPE_PERMANENT, eWard, oPC ) );
	
	// Save our local variables.
	SetLocalInt( oPC, SM_WARD_ENABLED_VAR, TRUE );
	SetLocalObject( oPC, SM_WARD_CREATOR_VAR, oArea );
	
	// Return our success.
	return TRUE;
}


int RemoveSilverymoonWards( object oPC ) {
	// Abort if they are not warded.
	if ( !GetIsWardedBySilverymoon( oPC ) ) return FALSE;
	
	// Get the creator, make sure it is valid.
	object oCreator = GetLocalObject( oPC, SM_WARD_CREATOR_VAR );
	if ( !GetIsObjectValid( oCreator ) ) return FALSE;
	
	// Strip effects.
	effect e;
	for ( e = GetFirstEffect( oPC ); GetIsEffectValid( e ); e = GetNextEffect( oPC ) ) {
		if ( GetEffectCreator( e ) != oCreator ) continue;
		RemoveEffect( oPC, e );
	}
	
	// Reset variables.
	DeleteLocalInt( oPC, SM_WARD_ENABLED_VAR );
	DeleteLocalObject( oPC, SM_WARD_CREATOR_VAR );
	
	// Return our successful removal.
	return TRUE;
}