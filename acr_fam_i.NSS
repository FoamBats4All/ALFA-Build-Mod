////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acr_fam_i
//    $Revision:: 1          $ current version of the file
//        $Date:: 2012-05-06 $ date the file was created or modified
//       Author : FoamBats4All
//
//    Var Prefix: ACR_FAM
//
//  Dependencies:
//
//  Description
//  Provides various functions for bringing NWN2's familiars closer in line to
//	their PnP counterparts, and getting information from the familiar data.
//
//  Revision History
//		2012-05-06	Foam	Initial version.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_db_persist_i"
#include "ginc_effect"
#include "acr_skills_i"
#include "acr_creature_i"
#include "acr_xp_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

const string ACR_FAM_ISPCFAM = "ACR_FAM_ISPCFAM";
const string ACR_FAM_ISDEAD = "ACR_FAM_ISDEAD";
const int ACR_FAM_DEATH_DC = 15;
const float ACR_FAM_DEATH_CHECK_HB = 18.0f;

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// ACR replacement for SummonFamiliar. Calls functions to alter the familiar
// based on PnP rules.
void ACR_SummonFamiliar( object oMaster );

// Links the familiar to the master, providing health, attack bonuses, saves,
// skill ranks, and potentially spell resistance.
void ACR_LinkFamiliarToMaster( object oMaster, object oFamiliar );

// Get the total combined levels of every class that provides a familiar.
int ACR_FamiliarMasterClassLevel( object oMaster );

// Updates the familiar's attack bonus to reflect the master's.
void ACR_SetFamiliarAttack( object oMaster, object oFamiliar );

// Updates the familiar's attack bonus to reflect the master's.
void ACR_SetFamiliarHP( object oMaster, object oFamiliar );

// Updates the familiar's skill ranks to reflect the master's.
void ACR_SetFamiliarRanks( object oMaster, object oFamiliar );

// Updates the familiar's saving throws to reflect the master's.
void ACR_SetFamiliarSaves( object oMaster, object oFamiliar );

// Grants the familiar spell resistance.
void ACR_SetFamiliarSR( object oMaster, object oFamiliar );

// Monitors to see if the familiar has died.
void ACR_FamiliarDeathCheckHB( object oMaster, object oFamiliar );

// Removes XP and sets the familiar death state to true.
void ACR_FamiliarOnDeath( object oFamiliar = OBJECT_SELF );

// Gets the global, persistent familiar death state.
int ACR_GetIsFamiliarDead( object oMaster );

// Sets the global, persistent familiar death state.
void ACR_SetIsFamiliarDead( object oMaster, int bIsDead );

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void ACR_SummonFamiliar( object oMaster ) {
	// Is the familiar marked as dead?
	if ( ACR_GetIsFamiliarDead( oMaster ) ) {
		SendMessageToPC( oMaster, "<c=orange>You currently do not have a familiar.</c>" );
		return;
	}
	
	SummonFamiliar( oMaster );
	object oFamiliar = GetAssociate( ASSOCIATE_TYPE_FAMILIAR, oMaster );
	
	// Link familiar to its master.
	ACR_LinkFamiliarToMaster( oMaster, oFamiliar );
}

void ACR_LinkFamiliarToMaster( object oMaster, object oFamiliar ) {
	// Set object data.
	SetLocalInt( oFamiliar, ACR_FAM_ISPCFAM, TRUE );
	
	// Alter familiar attributes.
	ACR_SetFamiliarHP( oMaster, oFamiliar );
	ACR_SetFamiliarAttack( oMaster, oFamiliar );
	ACR_SetFamiliarSaves( oMaster, oFamiliar );
	ACR_SetFamiliarRanks( oMaster, oFamiliar );
	ACR_SetFamiliarSR( oMaster, oFamiliar );
}

int ACR_FamiliarMasterClassLevel( object oMaster ) {
	return GetLevelByClass( CLASS_TYPE_WIZARD, oMaster ) + GetLevelByClass( CLASS_TYPE_SORCERER, oMaster );
}

void ACR_SetFamiliarAttack( object oMaster, object oFamiliar ) {
	int nAttackBonus = GetTRUEBaseAttackBonus( oMaster ) - GetTRUEBaseAttackBonus( oFamiliar );
	int nNumAttacks = ( ( nAttackBonus - 1 ) / 5 ) + 1;
	if ( nNumAttacks < 1 ) nNumAttacks = 1;
	ApplyEffectToObject( DURATION_TYPE_PERMANENT, EffectAttackIncrease( nAttackBonus ), oFamiliar );
	SetBaseAttackBonus( nNumAttacks, oFamiliar );
}

void ACR_SetFamiliarHP( object oMaster, object oFamiliar ) {
	int nFamiliarHPBonus = ( GetMaxHitPoints( oMaster ) / 2 ) - GetMaxHitPoints( oFamiliar );
	ApplyEffectToObject( DURATION_TYPE_PERMANENT, EffectBonusHitpoints( nFamiliarHPBonus ), oFamiliar );
	ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectHeal( nFamiliarHPBonus ), oFamiliar );
}

void ACR_SetFamiliarRanks( object oMaster, object oFamiliar ) {
	int i = 0;
	int nRows = GetNum2DARows( "skills" );
	for ( i = 0; i <= nRows; i++ ) {
		int nMasterRank = GetSkillRank( i, oMaster, TRUE );
		int nFamiliarRank = GetSkillRank( i, oFamiliar, TRUE );
		if ( nMasterRank > nFamiliarRank ) SetBaseSkillRank( oFamiliar, i, nMasterRank );
	}
}

void ACR_SetFamiliarSaves( object oMaster, object oFamiliar ) {
	// Set fortitude save.
	int nMasterSave = GetFortitudeSavingThrow( oMaster ) - GetAbilityModifier( ABILITY_CONSTITUTION, oMaster );
	int nFamiliarSave = GetFortitudeSavingThrow( oFamiliar ) - GetAbilityModifier( ABILITY_CONSTITUTION, oFamiliar );
	ApplyEffectToObject( DURATION_TYPE_PERMANENT, EffectSavingThrowIncrease( SAVING_THROW_FORT, nMasterSave - nFamiliarSave ), oFamiliar );
	
	// Set reflex save.
	nMasterSave = GetReflexSavingThrow( oMaster ) - GetAbilityModifier( ABILITY_DEXTERITY, oMaster );
	nFamiliarSave = GetReflexSavingThrow( oFamiliar ) - GetAbilityModifier( ABILITY_DEXTERITY, oFamiliar );
	ApplyEffectToObject( DURATION_TYPE_PERMANENT, EffectSavingThrowIncrease( SAVING_THROW_REFLEX, nMasterSave - nFamiliarSave ), oFamiliar );
	
	// Set willpower save.
	nMasterSave = GetWillSavingThrow( oMaster ) - GetAbilityModifier( ABILITY_WISDOM, oMaster );
	nFamiliarSave = GetWillSavingThrow( oFamiliar ) - GetAbilityModifier( ABILITY_WISDOM, oFamiliar );
	ApplyEffectToObject( DURATION_TYPE_PERMANENT, EffectSavingThrowIncrease( SAVING_THROW_WILL, nMasterSave - nFamiliarSave ), oFamiliar );
}

void ACR_SetFamiliarSR( object oMaster, object oFamiliar ) {
	if ( ACR_FamiliarMasterClassLevel( oMaster ) < 11 ) return;
	int nFamiliarSR = GetTotalLevels( oMaster, TRUE ) + 5;
	ApplyEffectToObject( DURATION_TYPE_PERMANENT, EffectSpellResistanceIncrease( nFamiliarSR ), oFamiliar );
}

void ACR_FamiliarDeathCheckHB( object oMaster, object oFamiliar ) {
	if ( !GetIsObjectValid( oFamiliar ) || GetIsDead( oFamiliar ) ) {
		if ( !GetHasFeat( FEAT_SUMMON_FAMILIAR, oMaster, FALSE ) ) {
			if ( GetHasEffectType( oMaster, EFFECT_TYPE_ABILITY_DECREASE, ABILITY_CONSTITUTION ) ) {
				ACR_FamiliarOnDeath( oFamiliar );
			}
		}
	}
	
	DelayCommand( ACR_FAM_DEATH_CHECK_HB, ACR_FamiliarDeathCheckHB( oMaster, oFamiliar ) );
}

void ACR_FamiliarOnDeath( object oFamiliar = OBJECT_SELF ) {
	object oMaster = GetMaster( oFamiliar );
	
	// Master data.
	int nMasterClassLevel = ACR_FamiliarMasterClassLevel( oMaster );
	
	// Roll fortitude save.
	int nXPLoss = nMasterClassLevel * -200;
	if ( FortitudeSave( oMaster, ACR_FAM_DEATH_DC, SAVING_THROW_FORT ) ) nXPLoss /= 2;
	
	// Subtract experience.
	SendMessageToPC( oMaster, "<c=orange>Your familiar has died. You have lost " + IntToString( nXPLoss ) + " experience.</c>" );
	ACR_GiveXPToPC( oMaster, nXPLoss );
	
	// Disallow the PC from summoning their familiar again.
	ACR_SetIsFamiliarDead( oMaster, TRUE );
}

int ACR_GetIsFamiliarDead( object oMaster ) {
	return ACR_GetPersistentInt( oMaster, ACR_FAM_ISDEAD );
}

void ACR_SetIsFamiliarDead( object oMaster, int bIsDead ) {
	ACR_SetPersistentInt( oMaster, ACR_FAM_ISDEAD, bIsDead );
}